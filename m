From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Aug 2013 12:26:05 -0700
Subject: [PATCH v3 2/5] ARM: mvebu: Add clock properties to Armada XP
 timer node
In-Reply-To: <1377013554-23389-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377013554-23389-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130820192605.4443.80245@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ezequiel Garcia (2013-08-20 08:45:51)
> With the addition of the Armada XP reference clock, we can now model
> accurately the available clock inputs for the timer: namely, nbclk
> and refclk. For each of this clock inputs we assign a name, for the
> driver to select as appropriate.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Looks good to me.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/arm/boot/dts/armada-xp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 50e404e..2642f55 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -63,6 +63,8 @@
>  
>                         timer at 20300 {
>                                 compatible = "marvell,armada-xp-timer";
> +                               clocks = <&coreclk 2>, <&refclk>;
> +                               clock-names = "nbclk", "fixed";
>                         };
>  
>                         coreclk: mvebu-sar at 18230 {
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
