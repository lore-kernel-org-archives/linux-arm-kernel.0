From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 12:49:14 +0200
Subject: [PATCH] ARM: cpuidle: declare cpuidle_ops __read_mostly
In-Reply-To: <20160810175403.53e218cf@xhacker>
References: <1470818997-808-1-git-send-email-jszhang@marvell.com>
 <20160810175403.53e218cf@xhacker>
Message-ID: <2742913.yoAdrazplg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 5:54:03 PM CEST Jisheng Zhang wrote:
> On Wed, 10 Aug 2016 16:49:57 +0800 Jisheng Zhang wrote:
> 
> > cpuidle_ops is initialized once by arm_cpuidle_read_ops() during
> > initialization, and thereafter is mostly read in arm_cpuidle_suspend()
> > 
> > The fact that it is mostly read and not written to makes it candidates
> > for __read_mostly declarations.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm/kernel/cpuidle.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > index 7dccc96..762e0929 100644
> > --- a/arch/arm/kernel/cpuidle.c
> > +++ b/arch/arm/kernel/cpuidle.c
> > @@ -19,7 +19,7 @@ extern struct of_cpuidle_method __cpuidle_method_of_table[];
> >  static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
> >       __used __section(__cpuidle_method_of_table_end);
> >  
> > -static struct cpuidle_ops cpuidle_ops[NR_CPUS];
> > +static struct cpuidle_ops cpuidle_ops[NR_CPUS] __read_mostly;
> 
> 
> oops, I just found that "arm: apply more __ro_after_init" from Kees
> marked cpuidle_ops as __ro_after_init, that also meet my need, so
> let's drop my patch.
> 
> 

Ok, just saw this reply and that matches up with what I just
wrote as well.

Thanks,

	Arnd
