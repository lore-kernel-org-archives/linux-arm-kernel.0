From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 02:09:33 +0100
Subject: [PATCHv1 1/3] arm: mvebu: add uartX labels for Armada SoC serial
 nodes
In-Reply-To: <ee5646b8e097b266f51a68f489644256d7c3df33.1416095841.git.arno@natisbad.org>
References: <cover.1416095841.git.arno@natisbad.org>
 <ee5646b8e097b266f51a68f489644256d7c3df33.1416095841.git.arno@natisbad.org>
Message-ID: <20141116010933.GB15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 01:04:12AM +0100, Arnaud Ebalard wrote:
> 
> This patch adds uartX labels for Armada SoC serial nodes. This is
> a preliminary work to be able to easily reference the serial lines
> in Device Tree files. One expected future use is when providing
> stdout-path property for barebox.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Acked-by: Andrew Lunn <andrew@lunn.ch>

Not a must, but it would be nice to make use of these in
armada-xp-lenovo-ix4-300d.dts, which currently has:

      	     stdout-path = "/soc/internal-regs/serial at 12000";

	  Andrew

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++--
>  arch/arm/boot/dts/armada-xp.dtsi     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 83286ec9702c..2be9723bcdf3 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -151,7 +151,7 @@
>  				status = "disabled";
>  			};
>  
> -			serial at 12000 {
> +			uart0: serial at 12000 {
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12000 0x100>;
>  				reg-shift = <2>;
> @@ -160,7 +160,8 @@
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> -			serial at 12100 {
> +
> +			uart1: serial at 12100 {
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12100 0x100>;
>  				reg-shift = <2>;
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index bff9f6c18db1..a68f5b837536 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -52,7 +52,7 @@
>  				reg = <0x11100 0x100>;
>  			};
>  
> -			serial at 12200 {
> +			uart2: serial at 12200 {
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12200 0x100>;
>  				reg-shift = <2>;
> @@ -61,7 +61,8 @@
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> -			serial at 12300 {
> +
> +			uart3: serial at 12300 {
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12300 0x100>;
>  				reg-shift = <2>;
> -- 
> 2.1.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
