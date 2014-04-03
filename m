From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 20:06:34 +0100
Subject: [PATCH 15/75] ARM: l2c: add and use L2C revision constants
In-Reply-To: <533BDA5E.6080205@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYVM-0005Ze-IW@rmk-PC.arm.linux.org.uk> <533BDA5E.6080205@monstr.eu>
Message-ID: <20140403190634.GV7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 11:37:34AM +0200, Michal Simek wrote:
> On 03/28/2014 04:15 PM, Russell King wrote:
> > The revision namespace is specific to the L2 cache part, so don't name
> > these with generic identifiers, use a part specific identifier.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/hardware/cache-l2x0.h | 22 ++++++++++++++++------
> >  arch/arm/mm/cache-l2x0.c                   | 10 +++++-----
> >  2 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> > index 6795ff743b3d..94fbcec216ae 100644
> > --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> > +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> > @@ -68,14 +68,24 @@
> >  /* Registers shifts and masks */
> >  #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
> >  #define L2X0_CACHE_ID_PART_L210		(1 << 6)
> > +#define L2X0_CACHE_ID_PART_L220		(2 << 6)
> >  #define L2X0_CACHE_ID_PART_L310		(3 << 6)
> >  #define L2X0_CACHE_ID_RTL_MASK          0x3f
> > -#define L2X0_CACHE_ID_RTL_R0P0          0x0
> > -#define L2X0_CACHE_ID_RTL_R1P0          0x2
> > -#define L2X0_CACHE_ID_RTL_R2P0          0x4
> > -#define L2X0_CACHE_ID_RTL_R3P0          0x5
> > -#define L2X0_CACHE_ID_RTL_R3P1          0x6
> > -#define L2X0_CACHE_ID_RTL_R3P2          0x8
> > +#define L210_CACHE_ID_RTL_R0P2_02	0x00
> > +#define L210_CACHE_ID_RTL_R0P1		0x01
> > +#define L210_CACHE_ID_RTL_R0P2_01	0x02
> > +#define L210_CACHE_ID_RTL_R0P3		0x03
> > +#define L210_CACHE_ID_RTL_R0P4		0x0b
> > +#define L210_CACHE_ID_RTL_R0P5		0x0f
> > +#define L220_CACHE_ID_RTL_R1P7_01REL0	0x06
> > +#define L310_CACHE_ID_RTL_R0P0          0x00
> > +#define L310_CACHE_ID_RTL_R1P0          0x02
> > +#define L310_CACHE_ID_RTL_R2P0          0x04
> > +#define L310_CACHE_ID_RTL_R3P0          0x05
> > +#define L310_CACHE_ID_RTL_R3P1          0x06
> > +#define L310_CACHE_ID_RTL_R3P1_50REL0	0x07
> > +#define L310_CACHE_ID_RTL_R3P2          0x08
> > +#define L310_CACHE_ID_RTL_R3P3		0x09
> 
> Will be good to also clear tabs and spaces usage here
> (tabs or spaces not mixing both).

That's because I just modified the names of the old ones, and added the
new ones using tabs.  All +'d lines fixed to use tabs.  I haven't changed
the L2X0_CACHE_ID_RTL_MASK line because that would imply I'm doing a
cleanup to this rather than fixing these definitions.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
