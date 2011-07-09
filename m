From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sat, 9 Jul 2011 10:20:08 +0200
Subject: [PATCH v2 3/5] ARM: ep93xx: increase NR_BANKS to 16 for
	support of 128MB RAM
In-Reply-To: <20110617103249.GB4416@ibawizard.net>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
	<1307891100-31123-4-git-send-email-ynezz@true.cz>
	<ADE657CA350FB648AAC2C43247A983F001F3821F5A0A@AUSP01VMBX24.collaborationhost.net>
	<20110617103249.GB4416@ibawizard.net>
Message-ID: <20110709082007.GA17990@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr ?tetiar <ynezz@true.cz> [2011-06-17 12:32:49]:

> H Hartley Sweeten <hartleys@visionengravers.com> [2011-06-13 12:43:25]:
> 
> > On Sunday, June 12, 2011 8:05 AM, Petr ?tetiar wrote:
> > >
> > > I've got hands on one ts-7300 board, which is equiped with 128MB RAM in two
> > > 64MB memory chips, so it's 16 banks/8MB each. Without this patch, the bootmem
> > > init code complains about small NR_BANKS number and only lower 64MB is
> > > accessible.
> > >
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> > > Cc: Ryan Mallon <ryan@bluewatersys.com>
> > > Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> > > ---
> > >  arch/arm/include/asm/setup.h |    6 +++++-
> > >  1 files changed, 5 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> > > index ee2ad8a..b13720d 100644
> > > --- a/arch/arm/include/asm/setup.h
> > > +++ b/arch/arm/include/asm/setup.h
> > > @@ -192,7 +192,11 @@ static struct tagtable __tagtable_##fn __tag = { tag, fn }
> > >  /*
> > >   * Memory map description
> > >   */
> > > -#define NR_BANKS 8
> > > +#ifdef CONFIG_ARCH_EP93XX
> > > +# define NR_BANKS 16
> > > +#else
> > > +# define NR_BANKS 8
> > > +#endif
> > >  
> > >  struct membank {
> > >  	phys_addr_t start;
> > 
> > I would like Russell's opinion on this patch before it's accepted into his
> > Patch Tracker.
> > 
> > But, as far as the ep93xx support goes...
> > 
> > Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> Hello Russell,
> 
> could I kindly ask you about your opinnion on this patch? Thanks a lot.

Ping. Thanks a lot.

-- ynezz
