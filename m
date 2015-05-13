From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 09:59:22 +0300
Subject: [PATCH v2 3/4] mtd: mxc_nand: fix truncate of unaligned oob
 copying
In-Reply-To: <20150513064734.GF28888@pengutronix.de>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <ff526c6b889682e36e7d086dd5e6dec8936f86d9.1430636819.git.baruch@tkos.co.il>
 <20150508072432.GJ12671@pengutronix.de>
 <20150513051202.GI2558@tarshish>
 <20150513063903.GC28888@pengutronix.de>
 <20150513064404.GM2558@tarshish>
 <20150513064734.GF28888@pengutronix.de>
Message-ID: <20150513065922.GN2558@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, May 13, 2015 at 08:47:34AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, May 13, 2015 at 09:44:04AM +0300, Baruch Siach wrote:
> > > I thought we could get rid of the memcpy32 variants. Where do we need
> > > memcpy32_* where memcpy16 wouldn't work?
> > 
> > memcpy16 should work, but would take twice as much IO/memory accesses. That 
> > would definitely affect performance, as this is the flash data read/write hot 
> > path. I didn't test, though.
> > 
> > Are you sure we want to do that?
> no, I'm not sure. But I think it's worth to test how much performance
> degrades.

That will have to wait a few weeks as I don't have the hardware handy at the 
moment.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
