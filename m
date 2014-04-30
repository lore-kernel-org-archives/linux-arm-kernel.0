From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Apr 2014 02:45:07 +0200
Subject: [PATCH 2/4] ARM: shmobile: marzen: Remove early_printk from
 command line
In-Reply-To: <1398757406-30920-3-git-send-email-horms+renesas@verge.net.au>
References: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
 <1398757406-30920-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5762305.SPmcAFynTG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 29 April 2014 16:43:24 Simon Horman wrote:
> As far as I understand things this does not have any affect.
> So remove it.

The earlyprintk parameter actually makes a different when early printk support 
is enabled in the kernel. As that's not enabled by default, dropping it from 
the default command line is fine with me.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts
> b/arch/arm/boot/dts/r8a7779-marzen.dts index 2c727cd..769ae84 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -19,7 +19,7 @@
>  	compatible = "renesas,marzen", "renesas,r8a7779";
> 
>  	chosen {
> -		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200
> ignore_loglevel root=/dev/nfs ip=on"; +		bootargs = "console=ttySC2,115200
> ignore_loglevel root=/dev/nfs ip=on"; };
> 
>  	memory {

-- 
Regards,

Laurent Pinchart
