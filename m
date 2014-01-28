From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 28 Jan 2014 14:13:03 +1100
Subject: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
In-Reply-To: <20140123003838.GA10182@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
 <20140123003838.GA10182@windriver.com>
Message-ID: <1390878783.3872.63.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-22 at 19:38 -0500, Paul Gortmaker wrote:

> Thanks, it was a great help as it uncovered a few issues in fringe arch
> that I didn't have toolchains for, and I've fixed all of those up.
> 
> I've noticed that powerpc has been un-buildable for a while now; I have
> used this hack patch locally so I could run the ppc defconfigs to check
> that I didn't break anything.  Maybe useful for linux-next in the
> interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)

Can you and/or Aneesh submit that as a proper patch (with S-O-B
etc...) ?

Thanks !

Cheers,
Ben.

> Paul.
> --
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d27960c89a71..d0f070a2b395 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>  
>  #define pmd_move_must_withdraw pmd_move_must_withdraw
> -typedef struct spinlock spinlock_t;
> -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> -					 spinlock_t *old_pmd_ptl)
> +struct spinlock;
> +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> +					 struct spinlock *old_pmd_ptl)
>  {
>  	/*
>  	 * Archs like ppc64 use pgtable to store per pmd
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
