From: mdf@kernel.org (Moritz Fischer)
Date: Tue, 25 Jul 2017 09:49:17 -0700
Subject: [PATCH 09/10] arm64: zynqmp: Add new uartps compatible string
In-Reply-To: <4babfd9b8311073566a5d5730353c035bb5afa2a.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
 <4babfd9b8311073566a5d5730353c035bb5afa2a.1500552941.git.michal.simek@xilinx.com>
Message-ID: <20170725164917.GB30669@tyrael.ni.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:17:08PM +0200, Michal Simek wrote:
> Mainline kernel has r1p12 compatible string now. Use this new compatible
> string and also append generic compatible string.
> Keep in your mind that using this generic compatible string not all uart
> features will be available.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 4adf5285f56d..9304249a23ed 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -407,7 +407,7 @@
>  		};
>  
>  		uart0: serial at ff000000 {
> -			compatible = "cdns,uart-r1p8";
> +			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 21 4>;
> @@ -416,7 +416,7 @@
>  		};
>  
>  		uart1: serial at ff010000 {
> -			compatible = "cdns,uart-r1p8";
> +			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 22 4>;
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/57e69434/attachment.sig>
