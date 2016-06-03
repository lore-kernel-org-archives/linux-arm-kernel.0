From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 3 Jun 2016 10:32:26 +0800
Subject: [PATCH 1/3] arm64: move the PTE_VALID to pgtable-hwdef.h
In-Reply-To: <20160602181609.GF7697@arm.com>
References: <1464574468-22700-1-git-send-email-shijie.huang@arm.com>
 <20160602181609.GF7697@arm.com>
Message-ID: <20160603023224.GA23297@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 07:16:09PM +0100, Will Deacon wrote:
> On Mon, May 30, 2016 at 10:14:26AM +0800, Huang Shijie wrote:
> > The PTE_VALID is used to check whether the page descriptor is valid.
> > It's not a software defined PTE bits, such as PTE_WRITE/PTE_DIRTY.
> > 
> > So move it to the proper header file: pgtable-hwdef.h.
> > 
> > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> > ---
> >  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
> >  arch/arm64/include/asm/pgtable-prot.h  | 1 -
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index 2813748..eeb3269 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -154,6 +154,7 @@
> >  #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
> >  #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
> >  #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
> > +#define PTE_VALID		(_AT(pteval_t, 1) << 0)
> >  #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
> >  #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
> >  #define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
> > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> > index 29fcb33..5ac71f4 100644
> > --- a/arch/arm64/include/asm/pgtable-prot.h
> > +++ b/arch/arm64/include/asm/pgtable-prot.h
> > @@ -24,7 +24,6 @@
> >  /*
> >   * Software defined PTE bits definition.
> >   */
> > -#define PTE_VALID		(_AT(pteval_t, 1) << 0)
> >  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
> 
> So how would you define PTE_WRITE? It's a software bit in v8.0 and a
> hardware bit in v8.1 ;)
> 
> I don't mind shuffling the #defines about, I just think the boundaries
> are somewhat blurred and maybe it's a mistake to put software bits and
> hardware bits in separate headers.
Do you mind I move all the software bits(PTE_VALID/PTE_WRITE/PTE_DIRTY...)
to the pgtable-hwdef.h?

thanks
Huang Shijie
