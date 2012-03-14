From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 13:12:51 +0000
Subject: [PATCH v3 2/5] ARM: Add a printk loglevel modifier
In-Reply-To: <1331720516-11801-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720516-11801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201203141312.51547.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Uwe Kleine-K?nig wrote:
> This is a needed followup for
> 
>         ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> 
> otherwise no newline is printed for !CONFIG_CPU_CP15
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Should this be folded into the
> 
>         ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> 
> patch? Or should it come before it?
> 

I think this patch needs a better explanation. It looks to me that
it's simply a bug fix, because every printk that is not a continuation
of a previous printk needs a KERN_* line. In that case, it should
just get applied as a bug fix independent of the other patches.

However, if you sometimes don't have a newline after the previous
printk, this patch is actually wrong and should not get applied at
all.

	Arnd
