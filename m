From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 11 Aug 2014 11:57:12 +0100
Subject: master build: 1 failures 16 warnings (v3.16-8695-ga7d7a14)
In-Reply-To: <53E89DAC.2070801@citrix.com>
References: <E1XFj9r-0003ZJ-40@cassiel.sirena.org.uk>
 <20140808143227.GR17528@sirena.org.uk> <20140811100041.GM15344@arm.com>
 <53E89DAC.2070801@citrix.com>
Message-ID: <alpine.DEB.2.02.1408111156440.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Aug 2014, David Vrabel wrote:
> On 11/08/14 11:00, Will Deacon wrote:
> > On Fri, Aug 08, 2014 at 03:32:27PM +0100, Mark Brown wrote:
> >> On Fri, Aug 08, 2014 at 01:20:31PM +0100, Build bot for Mark Brown wrote:
> >>
> >>> Failed defconfigs:
> >>> 	arm64-allmodconfig
> >> #
> >>> Errors:
> >>
> >>> 	arm64-allmodconfig
> >>> ../arch/arm64/xen/../../arm/xen/grant-table.c:53:5: error: conflicting types for 'arch_gnttab_init'
> >>
> >> This build failure which was present in -next has now appeared in Linus'
> >> tree too.  It appears to be the result of a mismerge, we have two
> >> definitions of the function, one from b7dd0e350e0bd (x86/xen: safely map
> >> and unmap grant frames when in atomic context) with the old signature
> >> and one from 438b33c7145ca8a5131 (xen/grant-table: remove support for V2
> >> tables).
> > 
> > Stefano, Konrad: do you have a fix queued for this? I don't think there's a
> > lot I can do from the arm64 side.
> 
> I am going to apply this patch.
> 
> 8<------------------------
> arm/xen: remove duplicate arch_gnttab_init() function
> 
> This was introduced in commit e306e3be1cbe (Merge tag
> 'stable/for-linus-3.17-rc0-tag').
> 
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/xen/grant-table.c |    5 -----
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
> 1.7.10.4
> 
