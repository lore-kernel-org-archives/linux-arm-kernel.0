From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 04 Jan 2017 15:30:28 +0200
Subject: [RFC PATCH] arch: arm64: dts: add USB OTG interrupts support in
 ZynqMP device tree
In-Reply-To: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
Message-ID: <87tw9fvtor.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Manish Narani <manish.narani@xilinx.com> writes:
> This patch adds OTG interrupt support in device tree. It will add
> an extra interrupt line number dedicated to OTG events. This will
> enable OTG interrupts to serve in DWC3 OTG driver.
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 68a90833..ce9ad02 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -351,7 +351,7 @@
>  			compatible = "snps,dwc3";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
> -			interrupts = <0 65 4>;
> +			interrupts = <0 65 4>, <0 69 4>;

help the driver by passing names to these IRQ lines.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170104/aae7b52a/attachment-0001.sig>
