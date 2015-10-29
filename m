From: monstr@monstr.eu (Michal Simek)
Date: Thu, 29 Oct 2015 17:37:40 +0100
Subject: [PATCH 3/3] ARM64: zynqmp: DT: Add interrupt-controller property
 to GPIO
In-Reply-To: <1445617532-10228-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
 <1445617532-10228-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56324B54.9000607@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 06:25 PM, Soren Brinkmann wrote:
> GPIO can be used as interrupt-controller. Add the missing properties to
> the GPIO node.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 857eda5c7217..200fb588d0f5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -133,6 +133,8 @@
>  			clocks = <&misc_clk>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 16 4>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  			reg = <0x0 0xff0a0000 0x1000>;
>  		};
>  
> 

Applied.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151029/0e94b497/attachment.sig>
