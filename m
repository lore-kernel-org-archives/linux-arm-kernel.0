From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 17:19:26 +0800
Subject: [PATCH] ARM: cpuidle: declare cpuidle_ops __read_mostly
In-Reply-To: <2118361.tr3K3hSZxF@wuerfel>
References: <1470818997-808-1-git-send-email-jszhang@marvell.com>
 <2118361.tr3K3hSZxF@wuerfel>
Message-ID: <20160810171926.44557e35@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Wed, 10 Aug 2016 10:57:57 +0200 Arnd Bergmann wrote:

> On Wednesday, August 10, 2016 4:49:57 PM CEST Jisheng Zhang wrote:
> > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > index 7dccc96..762e0929 100644
> > --- a/arch/arm/kernel/cpuidle.c
> > +++ b/arch/arm/kernel/cpuidle.c
> > @@ -19,7 +19,7 @@ extern struct of_cpuidle_method __cpuidle_method_of_table[];
> >  static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
> >         __used __section(__cpuidle_method_of_table_end);
> >  
> > -static struct cpuidle_ops cpuidle_ops[NR_CPUS];
> > +static struct cpuidle_ops cpuidle_ops[NR_CPUS] __read_mostly;  
> 
> Should this perhaps be percpu data instead?
> 

Per my understanding, percpu is used for those vars with normal read/write
frequency, while the cpuidle_ops is read mostly, so IMHO, __read_mostly
is suitable, what do you think?

Thanks,
Jisheng
