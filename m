From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 May 2015 08:47:34 +0200
Subject: [PATCH v2 3/4] mtd: mxc_nand: fix truncate of unaligned oob
 copying
In-Reply-To: <20150513064404.GM2558@tarshish>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <ff526c6b889682e36e7d086dd5e6dec8936f86d9.1430636819.git.baruch@tkos.co.il>
 <20150508072432.GJ12671@pengutronix.de>
 <20150513051202.GI2558@tarshish>
 <20150513063903.GC28888@pengutronix.de>
 <20150513064404.GM2558@tarshish>
Message-ID: <20150513064734.GF28888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Wed, May 13, 2015 at 09:44:04AM +0300, Baruch Siach wrote:
> > I thought we could get rid of the memcpy32 variants. Where do we need
> > memcpy32_* where memcpy16 wouldn't work?
> 
> memcpy16 should work, but would take twice as much IO/memory accesses. That 
> would definitely affect performance, as this is the flash data read/write hot 
> path. I didn't test, though.
> 
> Are you sure we want to do that?
no, I'm not sure. But I think it's worth to test how much performance
degrades.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
