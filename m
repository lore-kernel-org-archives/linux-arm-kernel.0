From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 10 Feb 2010 10:33:31 +0200
Subject: [PATCH 2/3] mx25: add platform support for imxfb
In-Reply-To: <20100210075315.GB10185@pengutronix.de>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
	<20100210075315.GB10185@pengutronix.de>
Message-ID: <20100210083331.GB29489@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 08:53:15AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Feb 10, 2010 at 09:25:19AM +0200, Baruch Siach wrote:
> > @@ -233,6 +242,9 @@ int __init mx25_clocks_init(void)
> >  	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
> >  	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
> >  
> > +	/* Clock source for lcdc is upll */
> > +	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7), CRM_BASE + 0x64);
> > +
> 0x64?  Please define a register name for that constant.

I just followed the precedence set in the get_rate_per() routine above.  
Defining a register name is obviously better.

> Ditto for 7.

See arch/arm/mach-mx3/clock.c:mx31_clocks_init() and 
arch/arm/mach-mx3/clock-imx35.c:mx35_clocks_init(). This is probably a matter 
for a separate cleanup patch.

> Note I didn't look in the hardware manual, but I wonder if that should
> better go in the enable routine for lcdc?

OK. I'll do it there.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
