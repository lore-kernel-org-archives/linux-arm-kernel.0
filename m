From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Sun, 16 Nov 2014 11:51:54 +0100
Subject: [PATCH v4 6/6] ARM: zynq: DT: Add OCM controller node
In-Reply-To: <0a88d52b5e71fb220ca619180ec9ca746edad2b1.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
 <0a88d52b5e71fb220ca619180ec9ca746edad2b1.1415962281.git.michal.simek@xilinx.com>
Message-ID: <546881CA.2020801@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Am 14.11.2014 um 11:52 schrieb Michal Simek:
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index ce2ef5bec4f2..e217fb1c1169 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -150,6 +150,13 @@
>  			reg = <0xf8006000 0x1000>;
>  		};
> 
> +		ocmc: memory-controller at f800c000 {
> +			compatible = "xlnx,zynq-ocmc-1.0";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 3 4>;
> +			reg = <0xf800c000 0x1000>;
> +		};
> +
>  		uart0: serial at e0000000 {
>  			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>  			status = "disabled";

Not directly related to this patch: As one can see here, the node order
is quite a mess... According to Olof, nodes should be ordered by unit
address, whereas here some but not all seem ordered by node name. Would
you welcome a cleanup patch, or can you fix that yourself?

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/ca28033d/attachment.sig>
