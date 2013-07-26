From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jul 2013 14:23:32 +0200
Subject: [PATCH 04/10] ARM: sun6i: Add restart code for the A31
In-Reply-To: <20130726123559.66216580@skate>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130726123559.66216580@skate>
Message-ID: <20130726122332.GB3056@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jul 26, 2013 at 12:35:59PM +0200, Thomas Petazzoni wrote:
> Dear Maxime Ripard,
> 
> On Wed, 24 Jul 2013 00:25:06 +0200, Maxime Ripard wrote:
> > The Allwinner A31 has a sligthly different watchdog that requires a
> > different restart code.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-sunxi/sunxi.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > index 11326d9..c18ef3a 100644
> > --- a/arch/arm/mach-sunxi/sunxi.c
> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > @@ -32,6 +32,15 @@
> >  #define SUN4I_WATCHDOG_MODE_ENABLE		(1 << 0)
> >  #define SUN4I_WATCHDOG_MODE_RESET_ENABLE	(1 << 1)
> >  
> > +#define SUN6I_WATCHDOG1_IRQ_REG		0x00
> > +#define SUN6I_WATCHDOG1_CTRL_REG	0x10
> > +#define SUN6I_WATCHDOG1_CTRL_RESTART		(1 << 0)
> > +#define SUN6I_WATCHDOG1_CONFIG_REG	0x14
> > +#define SUN6I_WATCHDOG1_CONFIG_RESTART		(1 << 0)
> > +#define SUN6I_WATCHDOG1_CONFIG_IRQ		(1 << 1)
> > +#define SUN6I_WATCHDOG1_MODE_REG	0x18
> > +#define SUN6I_WATCHDOG1_MODE_ENABLE		(1 << 0)
> 
> Alignment is not nice, and the BIT() macro should be used.

Actually, the alignment is the one you would expect in the code.

Point taken for the BIT macro, I'll update it.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/fa138726/attachment.sig>
