From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 01 Jul 2010 17:18:33 +0900
Subject: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
In-Reply-To: <1277967954.2474.269.camel@tubuntu.research.nokia.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120719.2637.65586.stgit@baageli.muru.com>
	<1277967954.2474.269.camel@tubuntu.research.nokia.com>
Message-ID: <004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This value is set from bootloader, and kernel side only change the mode.
Right it runs by luck.

Thank you,
Kyungmin Park

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen at nokia.com]
> Sent: Thursday, July 01, 2010 4:06 PM
> To: ext Tony Lindgren
> Cc: linux-arm-kernel at lists.infradead.org; Kyungmin Park; linux-
> omap at vger.kernel.org
> Subject: Re: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-
> apollon.c
> 
> On Wed, 2010-06-30 at 14:07 +0200, ext Tony Lindgren wrote:
> > Use the new mux function for that.
> >
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-apollon.c |    3 +++
> >  drivers/video/omap/lcd_apollon.c    |    3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
> omap2/board-apollon.c
> > index b86a879..bc67026 100644
> > --- a/arch/arm/mach-omap2/board-apollon.c
> > +++ b/arch/arm/mach-omap2/board-apollon.c
> > @@ -332,6 +332,9 @@ static void __init omap_apollon_init(void)
> >  	/* REVISIT: where's the correct place */
> >  	omap_cfg_reg(W19_24XX_SYS_NIRQ);
> >
> > +	/* LCD PWR_EN */
> > +	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA |
> OMAP_PULL_UP);
> 
> LCD_PWR_EN sounds like output pin. However, I don't see lcd_apollon.c
> nor board-apollon.c set the gpio.
> 
> I don't know what omap_cfg_reg(M21_242X_GPIO11) does, but if it does the
> same thing as the line above, then does the apollon LCD work by luck?
> OMAP pulling the line up, and by chance the pull is stronger than the
> LCDs (possible) pull down, and thus the LCD is powered up...
> 
>  Tomi
