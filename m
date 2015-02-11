From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Wed, 11 Feb 2015 18:22:50 +0100
Subject: [PATCH 1/2] ARM: dts: zynq: Add missing alias node for zybo and
 parallella
In-Reply-To: <0a0e0579fb6e2794d2c0c6fb9186c5b43618f448.1423657710.git.michal.simek@xilinx.com>
References: <0a0e0579fb6e2794d2c0c6fb9186c5b43618f448.1423657710.git.michal.simek@xilinx.com>
Message-ID: <54DB8FEA.3050008@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.02.2015 um 13:29 schrieb Michal Simek:
> Add missing alias node.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/boot/dts/zynq-parallella.dts | 5 +++++
>  arch/arm/boot/dts/zynq-zybo.dts       | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> index ab1dc0a56cdd..6a5f51daa708 100644
> --- a/arch/arm/boot/dts/zynq-parallella.dts
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -23,6 +23,11 @@
>  	model = "Adapteva Parallella Board";
>  	compatible = "adapteva,parallella", "xlnx,zynq-7000";
>  
> +	aliases {
> +		ethernet0 = &gem0;
> +		serial0 = &uart1;
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x0 0x40000000>;
[snip]

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Please CC me next time, as I am refactoring this file into a .dtsi for
adding the USB nodes. I'll rebase on this one then.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150211/cff5fbf2/attachment.sig>
