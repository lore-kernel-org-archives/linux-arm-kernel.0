From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Apr 2015 10:31:41 -0700
Subject: [RFT PATCH] drm/exynos: Enable DP clock to fix display on
 Exynos5250 and other
In-Reply-To: <1427471856-20918-1-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Fri, 27 Mar 2015 16:57:36 +0100")
References: <1427471856-20918-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7h8udau9he.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> After adding display power domain for Exynos5250 in commit
> 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250") the
> display on Chromebook Snow and others stopped working after boot.
>
> The reason for this suggested Andrzej Hajda: the DP clock was disabled.
> This clock is required by Display Port and is enabled by bootloader.
> However when FIMD driver probing was deferred, the display power domain
> was turned off. This effectively reset the value of DP clock enable
> register.
>
> When exynos-dp is later probed, the clock is not enabled and display is
> not properly configured:
>
> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
> exynos-dp 145b0000.dp-controller: unable to config video
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
> Cc: <stable@vger.kernel.org>
>
> ---
>
> This should fix issue reported by Javier [1][2].
>
> Tested on Chromebook Snow (Exynos 5250). More testing would be great,
> especially on other Exynos 5xxx products.

I hoped to try this on my exynos5 boards, but it doesn't seem to apply
to linux-next or to Linus' master branch.

Are there some other dependencies here?

Kevin
