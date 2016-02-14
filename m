From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:43:45 +0800
Subject: [PATCH] ARM: dts: ls1043a: Add quirk for Erratum A009116
In-Reply-To: <1455080987-30786-1-git-send-email-rajesh.bhagat@freescale.com>
References: <1455080987-30786-1-git-send-email-rajesh.bhagat@freescale.com>
Message-ID: <20160214074345.GM6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:39:47AM +0530, Rajesh Bhagat wrote:
> Add "snps,quirk-frame-length-adjustment" property to USB3 node for erratum A009116.
> This property provides value of GFLADJ_30MHZ for post silicon frame length adjustment.

The commit log should be generally wrapped around column 70.  I fixed
it up and applied patch.

Shawn

> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 42a6154..be72bf5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -407,6 +407,7 @@
>  			reg = <0x0 0x2f00000 0x0 0x10000>;
>  			interrupts = <0 60 0x4>;
>  			dr_mode = "host";
> +			snps,quirk-frame-length-adjustment = <0x20>;
>  		};
>  
>  		usb1: usb3 at 3000000 {
> @@ -414,6 +415,7 @@
>  			reg = <0x0 0x3000000 0x0 0x10000>;
>  			interrupts = <0 61 0x4>;
>  			dr_mode = "host";
> +			snps,quirk-frame-length-adjustment = <0x20>;
>  		};
>  
>  		usb2: usb3 at 3100000 {
> @@ -421,6 +423,7 @@
>  			reg = <0x0 0x3100000 0x0 0x10000>;
>  			interrupts = <0 63 0x4>;
>  			dr_mode = "host";
> +			snps,quirk-frame-length-adjustment = <0x20>;
>  		};
>  
>  		sata: sata at 3200000 {
> -- 
> 2.6.2.198.g614a2ac
> 
> 
