From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Nov 2018 15:46:17 +0000
Subject: [PATCH] ARM: vfp: Fix wrong assignement to ufp_exc
In-Reply-To: <1541523938-13800-1-git-send-email-julien.thierry@arm.com>
References: <1541523938-13800-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20181108154616.GX30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 05:05:38PM +0000, Julien Thierry wrote:
> In vfp_preserve_user_clear_hwstate, ufp_exc->fpinst2 gets assigned to
> itself. It should actually be hwstate->fpinst2 that gets assigned to the
> ufp_exc field.
> 
> Fixes commit 3aa2df6ec2ca6bc143a65351cca4266d03a8bc41 ("ARM: 8791/1:
> vfp: use __copy_to_user() when saving VFP state").
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>

Please put this in the patch system, thanks.

> ---
>  arch/arm/vfp/vfpmodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index aff6e6e..ee7b079 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -573,7 +573,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
>  	 */
>  	ufp_exc->fpexc = hwstate->fpexc;
>  	ufp_exc->fpinst = hwstate->fpinst;
> -	ufp_exc->fpinst2 = ufp_exc->fpinst2;
> +	ufp_exc->fpinst2 = hwstate->fpinst2;
>  
>  	/* Ensure that VFP is disabled. */
>  	vfp_flush_hwstate(thread);
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
