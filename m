From: benzyg@ti.com (Gabay, Benzy)
Date: Mon, 26 Jul 2010 13:33:10 -0500
Subject: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
	powered 	off
In-Reply-To: <AANLkTim3RWv2-qi9UMg1imwKTJuh3GstdjMTxz64uOHf@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-20-git-send-email-ohad@wizery.com>
	<676FD6AA0F002F49B89E70F0C5EFD22C1311192A47@dlee04.ent.ti.com>
	<AANLkTim3RWv2-qi9UMg1imwKTJuh3GstdjMTxz64uOHf@mail.gmail.com>
Message-ID: <676FD6AA0F002F49B89E70F0C5EFD22C131128FA47@dlee04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Thursday, July 22, 2010 6:18 PM
> To: Gabay, Benzy
> Cc: linux-wireless at vger.kernel.org; linux-mmc at vger.kernel.org; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux at arm.linux.org.uk; Chikkature Rajashekar, Madhusudhan; Luciano
> Coelho; akpm at linux-foundation.org; San Mehat; Roger Quadros; Tony
> Lindgren; Nicolas Pitre; Pandita, Vikram; Kalle Valo
> Subject: Re: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
> powered off
> 
> Hi Gever,
> 
> On Wed, Jul 21, 2010 at 9:55 PM, Gabay, Benzy <benzyg@ti.com> wrote:
> > From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> > Sent: Wednesday, July 21, 2010 12:34 PM
> > To: linux-wireless at vger.kernel.org; linux-mmc at vger.kernel.org; linux-
> omap at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
> Chikkature Rajashekar, Madhusudhan; Luciano Coelho; akpm at linux-
> foundation.org; San Mehat; Roger Quadros; Tony Lindgren; Nicolas Pitre;
> Pandita, Vikram; Kalle Valo; Ohad Ben-Cohen
> > Subject: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
> powered off
> >
> > Keep the MMC3 wl1271 WLAN device powered off until its
> > SDIO function driver requests otherwise.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > ---
> > ?arch/arm/mach-omap2/board-zoom-peripherals.c | ? ?1 +
> > ?arch/arm/mach-omap2/hsmmc.c ? ? ? ? ? ? ? ? ?| ? ?3 +++
> > ?arch/arm/mach-omap2/hsmmc.h ? ? ? ? ? ? ? ? ?| ? ?1 +
> > ?arch/arm/plat-omap/include/plat/mmc.h ? ? ? ?| ? ?3 +++
> > ?drivers/mmc/host/omap_hsmmc.c ? ? ? ? ? ? ? ?| ? ?3 +++
> > ?5 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > index 3230801..3ab9125 100644
> > --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > @@ -217,6 +217,7 @@ static struct omap2_hsmmc_info mmc[] __initdata =
> {
> > ? ? ? ? ? ? ? ?.gpio_wp ? ? ? ?= -EINVAL,
> > ? ? ? ? ? ? ? ?.gpio_cd ? ? ? ?= -EINVAL,
> > ? ? ? ? ? ? ? ?.ocr_mask ? ? ? = MMC_VDD_165_195,
> > + ? ? ? ? ? ? ? .dont_power_card = true,
> > ? ? ? ? ? ? ? ?.priv_data ? ? ?= &omap_zoom_wlan_data,
> > ? ? ? ?},
> > ? ? ? ?{} ? ? ?/* Terminator */
> ...
> > --
> > 1.7.0.4
> >
> > [Benzy Gabay] small comment: Please make sure that all 127x related
> changes are not bounded only to MMC3.
> > On OMAP4 WLAN is used on MMC5.
> 
> 
> The only place MMC3 is bound is in the board files (see code snippet
> above), so that should be ok.
> 
> I can probably split this patch to make this more obvious just by
> reading the diffstat if you prefer.


Yep. That will be great.

Benzy


> 
> 
> Thanks,
> Ohad.
> 
> 
> >
