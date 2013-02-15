From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 16:48:06 -0500
Subject: [PATCH v2 2/5] clocksource: time-armada-370-xp: add local
 timer support
In-Reply-To: <511EAB9F.9060609@free-electrons.com>
References: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
 <1359135165-32108-3-git-send-email-gregory.clement@free-electrons.com>
 <20130215212130.GC14746@titan.lakedaemon.net>
 <511EAB9F.9060609@free-electrons.com>
Message-ID: <20130215214806.GH14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 10:41:51PM +0100, Gregory CLEMENT wrote:
> On 02/15/2013 10:21 PM, Jason Cooper wrote:
> > On Fri, Jan 25, 2013 at 06:32:42PM +0100, Gregory CLEMENT wrote:
> >> On the SOCs Armada 370 and Armada XP, each CPU comes with two private
> >> timers. This patch use the timer 0 of each CPU as local timer for the
> >> clockevent if CONFIG_LOCAL_TIMER is selected. In the other case, use
> >> only the private Timer 0 of CPU 0.
> >>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  drivers/clocksource/time-armada-370-xp.c |  150 ++++++++++++++++++++++--------
> >>  1 file changed, 112 insertions(+), 38 deletions(-)
> > 
> > After applying the first two patches in this series to mvebu/drivers I get:
> > 
> >   CC      arch/arm/mach-mvebu/irq-armada-370-xp.o
> > arch/arm/mach-mvebu/irq-armada-370-xp.c: In function 'armada_370_xp_mpic_irq_map':
> > arch/arm/mach-mvebu/irq-armada-370-xp.c:87:11: error: 'ARMADA_370_XP_MAX_PER_CPU_IRQS' undeclared (first use in this function)
> > arch/arm/mach-mvebu/irq-armada-370-xp.c:87:11: note: each undeclared identifier is reported only once for each function it appears in
> > make[1]: *** [arch/arm/mach-mvebu/irq-armada-370-xp.o] Error 1
> > make: *** [arch/arm/mach-mvebu] Error 2
> > 
> > with mvebu_defconfig.
> > 
> > Is there a dependency I missed?  I'm not finding anything obvious.  The
> > same occurs if I enable LOCAL_TIMER.
> 
> It depends on "arm: mvebu: Improve the SMP support of the interrupt controller"
> 
> As you have pulled this patch few weeks ago I forgot to this dependency, sorry.

Cool, thanks!

Jason.
