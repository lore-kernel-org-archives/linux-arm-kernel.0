From: monstr@monstr.eu (Michal Simek)
Date: Fri, 19 Aug 2016 12:31:24 +0200
Subject: [PATCH 2/2] ARM64: zynqmp: Correct the watchdog timer interrupt
 number
In-Reply-To: <1d73c4f687ebab2f5f2c48f9174055f08bdd40dd.1470749892.git.michal.simek@xilinx.com>
References: <73e2ff39077d4593e92a1b484fbb586afcddb4bf.1470749892.git.michal.simek@xilinx.com>
 <1d73c4f687ebab2f5f2c48f9174055f08bdd40dd.1470749892.git.michal.simek@xilinx.com>
Message-ID: <9a5d718d-3626-ec41-e508-6d9ac982a8f1@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9.8.2016 15:38, Michal Simek wrote:
> From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> 
> Corrected the watchdog timer interrupt number.
> Origin value was for CSUPMU watchdog.
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 8ed4f42e781b..3bae4b2675d9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -369,7 +369,7 @@
>  			compatible = "cdns,wdt-r1p2";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
> -			interrupts = <0 52 1>;
> +			interrupts = <0 113 1>;
>  			reg = <0x0 0xfd4d0000 0x0 0x1000>;
>  			timeout-sec = <10>;
>  		};
> 

Applied both.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/023e5fa6/attachment.sig>
