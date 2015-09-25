From: a0131933@ti.com (Lokesh Vutla)
Date: Fri, 25 Sep 2015 18:27:23 +0530
Subject: [PATCH 07/17] ARM: dts: am4372: add reset data
In-Reply-To: <1443104818-993-8-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
 <1443104818-993-8-git-send-email-t-kristo@ti.com>
Message-ID: <560544B3.3090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Thursday 24 September 2015 07:56 PM, Tero Kristo wrote:
> Add reset data for pruss, gfx, wkup-m3 and system reset.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 0447c04a..fcc8d31 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -116,12 +116,15 @@
>  				reg-names = "umem", "dmem";
>  				ti,hwmods = "wkup_m3";
>  				ti,pm-firmware = "am335x-pm-firmware.elf";
> +				reset-names = "wkup_m3";
> +				resets = <&prcm 0x2000 0x10 3 0x14 5>;
>  			};
>  
>  			prcm: prcm at 1f0000 {
>  				compatible = "ti,am4-prcm";
>  				reg = <0x1f0000 0x11000>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				#reset-cells = <5>;
>  
>  				prcm_clocks: clocks {
>  					#address-cells = <1>;
> @@ -130,6 +133,12 @@
>  
>  				prcm_clockdomains: clockdomains {
>  				};
> +
> +				system_reset: system_reset {
> +					compatible = "ti,system-reset";
> +					reset-names = "system";
> +					reset-cells = <&prcm 0x4000 0 0 4 0>;
This should be resets instead of reset-cells.
With this change, reboot is functional on AM437x GP evm.

Thanks and regards,
Lokesh
