From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Feb 2015 10:19:41 -0600
Subject: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
In-Reply-To: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
References: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <20150224161941.GM29829@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 10:10:43AM -0600, Robert Nelson wrote:
> Fixes: http://bugs.elinux.org/issues/127
> 
> the bb.org community was seeing random reboots before this change.
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

that's a dead giveaway considering the connector in the board :-)

Thanks

Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 6cc25ed..2c6248d 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -195,6 +195,7 @@
>  
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "peripheral";
>  };
>  
>  &usb1 {
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/aec7e793/attachment.sig>
