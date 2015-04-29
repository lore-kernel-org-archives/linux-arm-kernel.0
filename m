From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Apr 2015 08:56:50 +0900
Subject: [RFT PATCH] drm/exynos: Enable DP clock to fix display on
 Exynos5250 and other
In-Reply-To: <7h8udau9he.fsf@deeprootsystems.com>
References: <1427471856-20918-1-git-send-email-k.kozlowski@samsung.com>
 <7h8udau9he.fsf@deeprootsystems.com>
Message-ID: <CAJKOXPc6Epy_L+djManggcaYLaOrQ_c2S0=_GgU=dikuY1UU0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-30 2:31 GMT+09:00 Kevin Hilman <khilman@kernel.org>:
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
>
>> After adding display power domain for Exynos5250 in commit
>> 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250") the
>> display on Chromebook Snow and others stopped working after boot.
>>
>> The reason for this suggested Andrzej Hajda: the DP clock was disabled.
>> This clock is required by Display Port and is enabled by bootloader.
>> However when FIMD driver probing was deferred, the display power domain
>> was turned off. This effectively reset the value of DP clock enable
>> register.
>>
>> When exynos-dp is later probed, the clock is not enabled and display is
>> not properly configured:
>>
>> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
>> exynos-dp 145b0000.dp-controller: unable to config video
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
>> Cc: <stable@vger.kernel.org>
>>
>> ---
>>
>> This should fix issue reported by Javier [1][2].
>>
>> Tested on Chromebook Snow (Exynos 5250). More testing would be great,
>> especially on other Exynos 5xxx products.
>
> I hoped to try this on my exynos5 boards, but it doesn't seem to apply
> to linux-next or to Linus' master branch.
>
> Are there some other dependencies here?

It is already applied:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1c363c7cccf64128087002b0779986ad16aff6dc

Best regards,
Krzysztof
