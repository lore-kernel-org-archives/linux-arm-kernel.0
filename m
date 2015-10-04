From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Oct 2015 08:52:21 +0900
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5611BBB5.9030403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.10.2015 01:24, Marc Zyngier wrote:
> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
> it becomes possible to cleanup the open-coded versions of the same
> macro that have been added to some private irqchips implementations.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-exynos/suspend.c       | 3 ++-

I guess you want to push it through the tip tree? If yes, then for Samsung:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

(if not then please split it per mach)

Best regards,
Krzysztof


>  arch/arm/mach-imx/gpc.c              | 8 ++------
>  arch/arm/mach-omap2/omap-wakeupgen.c | 8 ++------
>  3 files changed, 6 insertions(+), 13 deletions(-)
> 
