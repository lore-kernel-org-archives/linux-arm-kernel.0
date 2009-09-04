From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Sep 2009 12:33:47 -0700
Subject: [PATCH] OMAP4: MMC driver support on OMAP4
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9B8A526@dbde02.ent.ti.com>
References: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
	<20090904121912.4b4e2b5a.akpm@linux-foundation.org>
	<FCCFB4CDC6E5564B9182F639FC35608702F9B8A526@dbde02.ent.ti.com>
Message-ID: <20090904193347.GD15715@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pandita, Vikram <vikram.pandita@ti.com> [090904 12:24]:
> Andrew/Kishore
> 
> >-----Original Message-----
> >From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Andrew
> >Morton
> >Sent: Friday, September 04, 2009 2:19 PM
> >
> >On Wed, 2 Sep 2009 18:54:36 +0530 (IST)
> >"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
> >
> >> This Patch adds basic support for all 5 MMC controllers on OMAP4.
> >>
> >> -Kishore
> >>
> >> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> >> ---
> >> This patch doesn't include mmc-regulator support
> >>
> >
> >This looks like an ARM patch more than an MMC patch.  I grabbed it as
> >an MMC thing but hopefully someone else will grab it for a more
> >appropriate tree.
> 
> A patch split is required:
> 
> >>  arch/arm/mach-omap2/devices.c          |   42 +++++++++++++++++++++++++++++----
> >>  arch/arm/plat-omap/include/mach/irqs.h |    2 +
> >>  arch/arm/plat-omap/include/mach/mmc.h  |    9 ++++++-
> 
> These files will go through linux-omap -> arm: to RMK
> 
> >>  drivers/mmc/host/Kconfig               |    6 ++--
> >>  drivers/mmc/host/omap_hsmmc.c          |   10 +++++++
> >>  5 files changed, 60 insertions(+), 9 deletions(-)
> 
> These files can go through Andrew.

No need to split it IMHO, it's best to merge it all together
via Andrew's MMC queue as it should not conflict with other
arch/arm/*omap* stuff.

Acked-by: Tony Lindgren <tony@atomide.com>
