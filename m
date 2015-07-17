From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jul 2015 22:48:42 -0700
Subject: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
In-Reply-To: <20150716135413.GD7576@n2100.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
 <20150716064854.GG17550@atomide.com>
 <20150716135413.GD7576@n2100.arm.linux.org.uk>
Message-ID: <20150717054842.GS17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150716 06:56]:
> On Wed, Jul 15, 2015 at 11:48:54PM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Russell King <rmk+kernel@arm.linux.org.uk> [150715 10:50]:
> > > Restore the OMAP4 barrier behaviour using the new implementation which
> > > allows multiplatform systems to hook into the mb() and wmb() ARM
> > > implementations to perform any necessary additional barrier maintanence.
> > 
> > I'm getthing this with omap2plus_defconfig with the last patch
> > applied:
> > 
> > arch/arm/mach-omap2/omap4-common.c: In function ?omap4_sram_init?:
> > arch/arm/mach-omap2/omap4-common.c:138:14: error: implicit declaration of function ?of_get_named_gen_pool? [-Werror=implicit-function-declaration]
> >   sram_pool = of_get_named_gen_pool(np, "sram", 0);
> >               ^
> > arch/arm/mach-omap2/omap4-common.c:138:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> >   sram_pool = of_get_named_gen_pool(np, "sram", 0);
> >             ^
> 
> I'd forgotten to merge in the merge window fixes for this... which have now
> been lost.  This needs to become of_gen_pool_get() in 4.2-rc1 and later.

OK with that change looks good to me, so please feel free to
add for the whole series:

Acked-by: Tony Lindgren <tony@atomide.com>
