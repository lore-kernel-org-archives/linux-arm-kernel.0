From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Aug 2017 15:45:52 +0200
Subject: [PATCH] ARM64: dts: marvell: armada37xx: Fix number of GPIO on
 south bridge
In-Reply-To: <20170801160135.10434-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 1 Aug 2017 18:01:35 +0200")
References: <20170801160135.10434-1-gregory.clement@free-electrons.com>
Message-ID: <87h8xq9j73.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., ao?t 01 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The number of pins in South Bridge is 30 and not 29. There is a fix for
> the driver for the pinctrl, but a fix is also need at device tree level
> for the GPIO.
>
> Fixes: afda007feda5 ("ARM64: dts: marvell: Add pinctrl nodes for Armada
> 3700")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/fixes

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index dbcc3d4e2ed5..51763d674050 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -219,7 +219,7 @@
>  				reg = <0x18800 0x100>, <0x18C00 0x20>;
>  				gpiosb: gpio {
>  					#gpio-cells = <2>;
> -					gpio-ranges = <&pinctrl_sb 0 0 29>;
> +					gpio-ranges = <&pinctrl_sb 0 0 30>;
>  					gpio-controller;
>  					interrupts =
>  					<GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.13.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
