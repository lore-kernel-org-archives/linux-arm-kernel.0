From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Aug 2013 12:25:37 -0700
Subject: [PATCH v3 1/5] ARM: mvebu: Add the reference 25 MHz fixed-clock to
 Armada XP
In-Reply-To: <1377013554-23389-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377013554-23389-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130820192537.4443.18515@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ezequiel Garcia (2013-08-20 08:45:50)
> The Armada XP SoC has a reference 25 MHz fixed-clock that is used in
> some controllers such as the timer and the watchdog. This commit adds
> a DT representation of this clock through a fixed-clock compatible node.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Looks good to me.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/arm/boot/dts/armada-xp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 549151e..50e404e 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -162,4 +162,13 @@
>                         };
>                 };
>         };
> +
> +       clocks {
> +               /* 25 MHz reference crystal */
> +               refclk: oscillator {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <25000000>;
> +               };
> +       };
>  };
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
