From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 10:48:48 -0700
Subject: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
In-Reply-To: <CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-5-git-send-email-arnd@arndb.de>
	<CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
Message-ID: <20111003174844.GQ6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bjarne Steinsbo <bsteinsbo@gmail.com> [111002 08:22]:
> Arnd,
> 
> Ref http://www.spinics.net/lists/linux-omap/msg57274.html
> 
> Don't get me wrong.  This is not about you "stealing" my patch, or
> anything like that.  But look also at thread starting at
> http://www.spinics.net/lists/linux-omap/msg57667.html Also a patch
> that I have posted previously.  Something is not right with the
> workflow when bugs are identified, patches are submitted, then
> ignored, only for someone else to fix the same bug.  Enough said.

Arnd, I suggest using Bjarne's earlier patch here:

Acked-by: Tony Lindgren <tony@atomide.com>
 

> On Sun, Oct 2, 2011 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Drivers that refer to a __devexit function in an operations
> > structure need to annotate that pointer with __devexit_p so
> > replace it with a NULL pointer when the section gets discarded.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > ?arch/arm/mach-omap2/smartreflex.c | ? ?2 +-
> > ?arch/arm/plat-omap/dma.c ? ? ? ? ?| ? ?2 +-
> > ?2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> > index 34c01a7..67bc6ce 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
> > ?}
> >
> > ?static struct platform_driver smartreflex_driver = {
> > - ? ? ? .remove ? ? ? ? = omap_sr_remove,
> > + ? ? ? .remove ? ? ? ? = __devexit_p(omap_sr_remove),
> > ? ? ? ?.driver ? ? ? ? = {
> > ? ? ? ? ? ? ? ?.name ? = "smartreflex",
> > ? ? ? ?},
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c22217c..f7150ba 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -2105,7 +2105,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
> >
> > ?static struct platform_driver omap_system_dma_driver = {
> > ? ? ? ?.probe ? ? ? ? ?= omap_system_dma_probe,
> > - ? ? ? .remove ? ? ? ? = omap_system_dma_remove,
> > + ? ? ? .remove ? ? ? ? = __devexit_p(omap_system_dma_remove),
> > ? ? ? ?.driver ? ? ? ? = {
> > ? ? ? ? ? ? ? ?.name ? = "omap_dma_system"
> > ? ? ? ?},
> > --
> > 1.7.5.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
