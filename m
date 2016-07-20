From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 20 Jul 2016 11:05:51 -0500
Subject: [PATCH 10/10] ARM: dts: Add Arria10 USB EDAC devicetree entry
In-Reply-To: <1468512408-5156-11-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
 <1468512408-5156-11-git-send-email-tthayer@opensource.altera.com>
Message-ID: <578FA15F.7000105@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2016 11:06 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree entries needed to support the Altera USB
> FIFO buffer EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index a506ec0..bd548ab 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -652,6 +652,14 @@
>  				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
>  					     <42 IRQ_TYPE_LEVEL_HIGH>;
>  			};
> +
> +			usb0-ecc at ff8c8800 {
> +				compatible = "altr,socfpga-usb-ecc";
> +				reg = <0xff8c8800 0x400>;
> +				altr,ecc-parent = <&usb0>;
> +				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
> +					     <34 IRQ_TYPE_LEVEL_HIGH>;
> +			};
>  		};
>  
>  		rst: rstmgr at ffd05000 {
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Dinh
