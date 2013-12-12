From: horms@verge.net.au (Simon Horman)
Date: Thu, 12 Dec 2013 22:41:57 +0900
Subject: [PATCH 00/10] sh-pfc: Fix GPIO to IRQ mapping
In-Reply-To: <1537589.LVeLx3Dqtn@avalon>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131212131139.GE30624@verge.net.au> <1537589.LVeLx3Dqtn@avalon>
Message-ID: <20131212134156.GB5049@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:15:35PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 12 December 2013 22:11:39 Simon Horman wrote:
> > On Wed, Dec 11, 2013 at 04:26:20AM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set fixes conversion from a GPIO number to an IRQ number in the
> > > sh-pfc driver in the device tree case.
> > > 
> > > Patches 01/10 to 05/10 clean up the driver to prepare it for the core fix
> > > in patch 06/10. As explained in patch 06/10 commit message, on non-DT
> > > platforms IRQ controllers associated with the GPIOs have a fixed IRQ base
> > > value known at compile time. The sh-pfc driver translates GPIO number to
> > > IRQ numbers using a hardcoded table. This mechanism breaks on DT
> > > platforms, as the IRQ base values are dynamic in that case.
> > > 
> > > The patch set fixes this by specifying IRQs associated with GPIOs in IRQ
> > > resources, populated automatically from the device tree. When IRQ
> > > resources
> > > are specified the driver requires one IRQ resource per GPIO able to
> > > generate an interrupt, and uses the translation table to compute the IRQ
> > > resource offset instead of the IRQ number.
> > > 
> > > Patches 07/10 to 09/10 then add PFC interrupts in DT for the SH73A0,
> > > R8A73A4 and R9A7740 SoCs. The only missing platform here is SH7372 due to
> > > its very uncomplete DT support. All other Renesas ARM platforms use a
> > > standaline GPIO driver and are thus not affected.
> > 
> > s/uncomplete/incomplete/
> > 
> > > Patch 10/10 finally adds a gpio-keys device to the Armadillo board DTS,
> > > allowing the whole patch set to the tested.
> > > 
> > > The sh-pfc changes need to be merged first. Linus, could you please
> > > provide a stable branch with the first 6 patches when you will apply them
> > > to your tree ?
> >
> > It seems to me that if Linus applies the pfc changes the
> > shmobile changes could be applied independently. Am I missing
> > and do the shmobile patches have build-dependencies on the pfc patches?
> 
> The DTS patches will result in the PFC platform device having IRQ resources. 
> The sh-pfc driver currently supports MEM resources only and will crash.

Thanks, got it :)
