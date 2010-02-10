From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 10 Feb 2010 14:25:30 +0200
Subject: [PATCH 2/3] mx25: add platform support for imxfb
In-Reply-To: <20100210083331.GB29489@jasper.tkos.co.il>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
	<20100210075315.GB10185@pengutronix.de>
	<20100210083331.GB29489@jasper.tkos.co.il>
Message-ID: <20100210122530.GD29489@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 10:33:31AM +0200, Baruch Siach wrote:
> On Wed, Feb 10, 2010 at 08:53:15AM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Feb 10, 2010 at 09:25:19AM +0200, Baruch Siach wrote:
> > > @@ -233,6 +242,9 @@ int __init mx25_clocks_init(void)
> > >  	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
> > >  	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
> > >  
> > > +	/* Clock source for lcdc is upll */
> > > +	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7), CRM_BASE + 0x64);
> > > +
> > Note I didn't look in the hardware manual, but I wonder if that should
> > better go in the enable routine for lcdc?
> 
> OK. I'll do it there.

Oops. I now see that the mx25 DEFINE_CLOCK() macro doesn't allow you currently 
to set an arbitrary .enable routine (following the mx27/mx31/mx35 clock 
implementation). So this gets a little tricky, and I'm not sure it worth the 
trouble. What do you think?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
