From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Mar 2014 18:23:04 +0100
Subject: [PATCH] ARM: dts: exynos4210-trats: add max8997 IRQ
In-Reply-To: <1394792001-7837-1-git-send-email-r.baldyga@samsung.com>
References: <1394792001-7837-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <53233AF8.9020501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 14.03.2014 11:13, Robert Baldyga wrote:
> This patch adds device tree node for IRQ used by max8997.
>

Generally, this patch does not add just a node, but rather "IRQ line 
specification for the MAX8997 PMIC chip and necessary pinctrl group to 
configure pull-up and driver strength of the pin".

Also it would be nice to mention a reason for this change, e.g. what can 
be achieved after applying this patch.

Otherwise looks good.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4210-trats.dts |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index 1d18428..0e1fc19 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -148,6 +148,14 @@
>   		};
>   	};
>
> +	pinctrl at 11000000 {
> +		max8997_irq: max8997-irq {
> +			samsung,pins = "gpx0-7";
> +			samsung,pin-pud = <3>;
> +			samsung,pin-drv = <0>;
> +		};
> +	};
> +
>   	i2c at 13890000 {
>   		samsung,i2c-sda-delay = <100>;
>   		samsung,i2c-slave-addr = <0x10>;
> @@ -179,6 +187,11 @@
>   		max8997_pmic at 66 {
>   			compatible = "maxim,max8997-pmic";
>
> +			pinctrl-0 = <&max8997_irq>;
> +			pinctrl-names = "default";
> +
> +			interrupt-parent = <&gpx0>;
> +			interrupts = <7 0>;
>   			reg = <0x66>;
>
>   			max8997,pmic-buck1-uses-gpio-dvs;
>
