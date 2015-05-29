From: balbi@ti.com (Felipe Balbi)
Date: Fri, 29 May 2015 11:31:55 -0500
Subject: [PATCH] ARM: dts: Fix dm816x to use right compatible flag for MUSB
In-Reply-To: <1432916828-13171-1-git-send-email-tony@atomide.com>
References: <1432916828-13171-1-git-send-email-tony@atomide.com>
Message-ID: <20150529163127.GG2026@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 09:27:08AM -0700, Tony Lindgren wrote:
> With commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with
> musb_dsps") we need to use the right compatible flag to avoid issues
> with FIFO reads.
> 
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: George Cherian <george.cherian@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Fixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_dsps")

Acked-by: Felipe Balbi <balbi@ti.com>

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/dm816x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
> index de8427b..289806a 100644
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -382,7 +382,7 @@
>  			ti,hwmods = "usb_otg_hs";
>  
>  			usb0: usb at 47401000 {
> -				compatible = "ti,musb-am33xx";
> +				compatible = "ti,musb-dm816";
>  				reg = <0x47401400 0x400
>  				       0x47401000 0x200>;
>  				reg-names = "mc", "control";
> @@ -422,7 +422,7 @@
>  			};
>  
>  			usb1: usb at 47401800 {
> -				compatible = "ti,musb-am33xx";
> +				compatible = "ti,musb-dm816";
>  				reg = <0x47401c00 0x400
>  				       0x47401800 0x200>;
>  				reg-names = "mc", "control";
> -- 
> 2.1.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/89ae288e/attachment.sig>
