From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 28 Oct 2012 17:01:29 +0530
Subject: [RFC PATCH v3 16/16] ARM: dts: add AM33XX SPI support
In-Reply-To: <1350566815-409-17-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-17-git-send-email-mporter@ti.com>
Message-ID: <508D1791.1040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 6:56 PM, Matt Porter wrote:
> Adds AM33XX SPI support for am335x-bone and am335x-evm.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |   17 +++++++++++++++
>  arch/arm/boot/dts/am335x-evm.dts  |    9 ++++++++
>  arch/arm/boot/dts/am33xx.dtsi     |   43 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 5510979..23edfd8 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -18,6 +18,17 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  
> +	am3358_pinmux: pinmux at 44e10800 {
> +		spi1_pins: pinmux_spi1_pins {
> +			pinctrl-single,pins = <
> +				0x190 0x13	/* mcasp0_aclkx.spi1_sclk, OUTPUT_PULLUP | MODE3 */
> +				0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
> +				0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
> +				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> +			>;

Is there a single pinmux setting that provides SPI functionality on the
bone headers? Or this is specific to a cape you tested with?

Thanks,
Sekhar
