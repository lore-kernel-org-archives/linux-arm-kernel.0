From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Aug 2014 18:48:34 +0100
Subject: [PATCH] arm/xen: fix wrong conflict resolution of xen merge
In-Reply-To: <87fvh1vd49.fsf@igel.home>
References: <87fvh1vd49.fsf@igel.home>
Message-ID: <alpine.DEB.2.02.1408121846310.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Aug 2014, Andreas Schwab wrote:
> Remove duplicate definition of arch_gnttab_init.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Thanks for the patch, however David Vrabel already committed a fix for
this.



>  arch/arm/xen/grant-table.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/xen/grant-table.c b/arch/arm/xen/grant-table.c
> index 2c4041c..e437918 100644
> --- a/arch/arm/xen/grant-table.c
> +++ b/arch/arm/xen/grant-table.c
> @@ -49,8 +49,3 @@ int arch_gnttab_init(unsigned long nr_shared)
>  {
>  	return 0;
>  }
> -
> -int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status)
> -{
> -	return 0;
> -}
> -- 
> 2.0.4
> 
> 
> -- 
> Andreas Schwab, schwab at linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
