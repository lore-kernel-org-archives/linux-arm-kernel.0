From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Mar 2012 09:59:33 -0700
Subject: [PATCH 4/6] ARM: OMAP: fix missing __devexit_p() annotations
In-Reply-To: <CAORVsuUVC4hpotK=eybA=Eqtfg0+PivjwRUENjCwcLG2dp1Ucg@mail.gmail.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
 <E1S87wp-0000Mz-V8@rmk-PC.arm.linux.org.uk>
 <CAORVsuUVC4hpotK=eybA=Eqtfg0+PivjwRUENjCwcLG2dp1Ucg@mail.gmail.com>
Message-ID: <20120315165932.GY12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jean Pihet <jean.pihet@newoldbits.com> [120315 04:09]:
> Russell,
> 
> On Thu, Mar 15, 2012 at 11:30 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Missing __devexit_p() annotations in driver structures for remove functions
> > marked with __devexit is waiting for build errors to happen, such as:
> >
> > `omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/bui
> > lt-in.o: defined in discarded section `.devexit.text' of arch/arm/plat-omap/buil
> > t-in.o
> >
> > Add the necessary annotation, and as a result of audit, fix others which
> > are also missing in arch/arm/*omap*.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> > ?arch/arm/mach-omap2/smartreflex.c | ? ?2 +-
> > ?arch/arm/plat-omap/dma.c ? ? ? ? ?| ? ?2 +-
> > ?2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> > index 7e755bb..47c77a1 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
> > ?}
> >
> > ?static struct platform_driver smartreflex_driver = {
> > - ? ? ? .remove ? ? ? ? = omap_sr_remove,
> > + ? ? ? .remove ? ? ? ? = __devexit_p(omap_sr_remove),
> > ? ? ? ?.driver ? ? ? ? = {
> > ? ? ? ? ? ? ? ?.name ? = "smartreflex",
> > ? ? ? ?},
> Tony already has this change in his master branch, commit
> 149f1d5c8d2fd6879cdf93ca70f1cb745e698a1e ('ARM: OMAP2+: Fix devexit
> for smartreflex when CONFIG_HOTPLUG is not set').

Also same commit in arm-soc/for-next.

Regards,

Tony
