From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 3 Jun 2016 10:39:07 +0800
Subject: [PATCH] arm64: fix the wrong comment
In-Reply-To: <20160602180948.GE7697@arm.com>
References: <1464574369-22618-1-git-send-email-shijie.huang@arm.com>
 <20160602180948.GE7697@arm.com>
Message-ID: <20160603023905.GB23297@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 07:09:48PM +0100, Will Deacon wrote:
> On Mon, May 30, 2016 at 10:12:49AM +0800, Huang Shijie wrote:
> > Currently, we use the 48-bit for the kernel and user by default.
> > The comment becomes stale. This patch fixes the wrong comment.
> > 
> > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> > ---
> >  arch/arm64/mm/proc.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index c431787..421386759 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -209,8 +209,8 @@ ENTRY(__cpu_setup)
> >  	bic	x0, x0, x5			// clear bits
> >  	orr	x0, x0, x6			// set bits
> >  	/*
> > -	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
> > -	 * both user and kernel.
> > +	 * Set/prepare TCR. We use VA_BITS of address range for both
> > +	 * kernel and user.
> >  	 */
> 
> To be honest, all three of these comments (including the two in the
> context) are totally useless. Can we just remove them instead?

Do you mean we could remove the comments like this:

---
 arch/arm64/mm/proc.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c431787..286d016 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -208,10 +208,7 @@ ENTRY(__cpu_setup)
 	mrs	x0, sctlr_el1
 	bic	x0, x0, x5			// clear bits
 	orr	x0, x0, x6			// set bits
-	/*
-	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
-	 * both user and kernel.
-	 */
+
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
 	tcr_set_idmap_t0sz	x10, x9
-- 

thanks
Huang Shijie
