From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 May 2015 08:39:03 +0200
Subject: [PATCH v2 3/4] mtd: mxc_nand: fix truncate of unaligned oob
 copying
In-Reply-To: <20150513051202.GI2558@tarshish>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <ff526c6b889682e36e7d086dd5e6dec8936f86d9.1430636819.git.baruch@tkos.co.il>
 <20150508072432.GJ12671@pengutronix.de>
 <20150513051202.GI2558@tarshish>
Message-ID: <20150513063903.GC28888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 08:12:02AM +0300, Baruch Siach wrote:
> Hi Uwe,
> 
> On Fri, May 08, 2015 at 09:24:32AM +0200, Uwe Kleine-K?nig wrote:
> > On Sun, May 03, 2015 at 10:18:53AM +0300, Baruch Siach wrote:
> > > Copy to/from oob io area might not be aligned to 4 bytes. When 8 bit ECC is
> > > used, the buffer size is 26. Add memcpy16_{to,from}io, and use them to avoid
> > > truncating the buffer. Prefer memcpy32_{to,from}io when the buffer is properly
> > > aligned for better performance.
> > Did you measure this performance difference? I doubt it's worth the
> > complexity given that we're talking about buffers with a size of up to
> > 26 bytes.
> 
> We'll need both memcpy16_{to,from}io and memcpy32_{to,from}io anyway. So by 
> "complexity" you refer to the additional alignment check and memcpy32 
> fallback?
I thought we could get rid of the memcpy32 variants. Where do we need
memcpy32_* where memcpy16 wouldn't work?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
