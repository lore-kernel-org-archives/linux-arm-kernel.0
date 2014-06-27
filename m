From: balbi@ti.com (Felipe Balbi)
Date: Fri, 27 Jun 2014 10:57:13 -0500
Subject: [PATCH] arch: arm: mach-omap2: usb-tusb6010.c:  Cleaning up
 variable is set more than once
In-Reply-To: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20140627155713.GM8069@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 02:28:30PM +0200, Rickard Strandqvist wrote:
> A struct member variable is set to the same value more than once
> 
> This was found using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

I think there was a bigger series from Roger rewriting most of this, but
if I'm mistaken:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-tusb6010.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
> index e832bc7..8333400 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -95,7 +95,6 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
>  	dev_t.t_avdp_w = t_scsnh_advnh;
>  	dev_t.cyc_aavdh_we = 3;
>  	dev_t.cyc_wpl = 6;
> -	dev_t.t_ce_rdyz = 7000;
>  
>  	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
>  
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/71396a49/attachment.sig>
