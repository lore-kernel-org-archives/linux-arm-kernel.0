From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 08:26:40 +0000
Subject: [PATCH v2 resend] OMAP4: Pandaboard: Add omap_reserve
	functionality
In-Reply-To: <20101218020952.GO5941@atomide.com>
References: <1291793964-26769-1-git-send-email-raghuveer.murthy@ti.com>
	<20101218020952.GO5941@atomide.com>
Message-ID: <20101218082640.GA3047@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 06:09:53PM -0800, Tony Lindgren wrote:
> * Raghuveer Murthy <raghuveer.murthy@ti.com> [101207 23:31]:
> > This patch adds omap_reserve functionality to board-omap4panda.c.
> > Helps in the reserving boot time memory in SDRAM, used here for
> > framebuffer allocation.
> > 
> > This patch is in similar lines to commit id 71ee7dad9b6991, from
> > Russell king
> > 
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap4panda.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index da24745..0ccc24f 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
> >  	/* Maintainer: David Anders - Texas Instruments Inc */
> >  	.boot_params	= 0x80000100,
> >  	.map_io		= omap4_panda_map_io,
> > +	.reserve	= omap_reserve,

Please put .reserve before .map_io.
