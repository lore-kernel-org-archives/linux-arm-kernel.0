From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 19:38:43 +0200
Subject: [PATCH 2/7] pinctrl: samsung: Ensure that pad retention is
 disabled on driver init
In-Reply-To: <1485345031-2948-3-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115102eucas1p180bbbdbcc09381051ab86bed6cfad5d0@eucas1p1.samsung.com>
 <1485345031-2948-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170125173843.veihl4hcm5iagmno@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 12:50:26PM +0100, Marek Szyprowski wrote:
> When pin controller device is a part of power domain, there is no guarantee
> that the power domain was not turned off and then on during boot process
> before probing of the pin control driver. If it happened, then pin control
> driver should ensure that pad retention is turned off during its probe call.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
