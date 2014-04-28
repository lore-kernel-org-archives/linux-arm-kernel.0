From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 19:21:27 +0100
Subject: [PATCH 08/16] ARM: l2c: convert prima2 to generic l2c
 initialisation
In-Reply-To: <20140428173435.GE7719@beef>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1Weost-0002Pn-OT@rmk-PC.arm.linux.org.uk> <20140428173435.GE7719@beef>
Message-ID: <20140428182127.GQ26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 01:34:35PM -0400, Matt Porter wrote:
> On Mon, Apr 28, 2014 at 05:58:27PM +0100, Russell King wrote:
> > Along with this change, we can delete l2x0.c from prima2.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-prima2/Makefile |  1 -
> >  arch/arm/mach-prima2/common.c |  6 ++++++
> >  arch/arm/mach-prima2/l2x0.c   | 17 -----------------
> >  3 files changed, 6 insertions(+), 18 deletions(-)
> >  delete mode 100644 arch/arm/mach-prima2/l2x0.c
> 
> I can confirm that this approach fixes the boot failure on bcm281xx and
> bcm21664 against the previous set of l2c patches in -next.
> 
> Tested-by: Matt Porter <mporter@linaro.org>

Great, rather than taking that tested-by, I'll rework the patches such
that we avoid the breakage through the patch series.

The resulting patch series is now around 100 patches long...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
