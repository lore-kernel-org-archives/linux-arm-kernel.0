From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Dec 2012 08:38:56 -0800
Subject: [PATCH] ARM: OMAP2+: Fix compillation error in mach-omap2/timer.c
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9A56D@DBDE01.ent.ti.com>
References: <1355910609-31336-1-git-send-email-peter.ujfalusi@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC9A56D@DBDE01.ent.ti.com>
Message-ID: <20121219163856.GN4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bedia, Vaibhav <vaibhav.bedia@ti.com> [121219 02:18]:
> Hi Peter, Tony
> 
> On Wed, Dec 19, 2012 at 15:20:09, Ujfalusi, Peter wrote:
> > prom_add_property() has been renamed to of_add_property()
> > This patch fixes the following comilation error:
> > 
> > arch/arm/mach-omap2/timer.c: In function ?omap_get_timer_dt?:
> > arch/arm/mach-omap2/timer.c:178:3: error: implicit declaration of function ?prom_add_property? [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> > make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi Tony,
> > 
> > today's mainline does not compile due to this API rename in of core.
> > Not sure if we alreasy have fix for this pending.
> > 

Thanks applying.
 
> There following patches for needed to get omap2plus_defconfig build working
> 
> https://patchwork.kernel.org/patch/1810481/ - address the build breakage due to header file cleanup
> https://patchwork.kernel.org/patch/1810441/ - address the prom_add_property() issue
> http://marc.info/?l=linux-arm-kernel&m=135589966017628&w=2 - this crept in during a merge commit.

Thanks all these should be queued up somewhere now.

Regards,

Tony 
