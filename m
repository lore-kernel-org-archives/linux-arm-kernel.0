From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 12 Jul 2012 08:57:22 +0200
Subject: mxc-nand fix for 3.5 (Was: Re: [PATCH v2] mtd mxc_nand: use 32bit
 copy functions)
In-Reply-To: <1340970369.3070.166.camel@sauron.fi.intel.com>
References: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
 <1340970369.3070.166.camel@sauron.fi.intel.com>
Message-ID: <20120712065722.GA592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 02:46:09PM +0300, Artem Bityutskiy wrote:
> On Tue, 2012-05-29 at 10:16 +0200, Sascha Hauer wrote:
> > The following commit changes the function used to copy from/to
> > the hardware buffer to memcpy_[from|to]io. This does not work
> > since the hardware cannot handle the byte accesses used by these
> > functions. Instead of reverting this patch introduce 32bit
> > correspondents of these functions.
> 
> Pushed to l2-mtd.git, thanks!
The mxc_nand driver is completely useless with

	5775ba3 (mtd: mxc_nand: fix several sparse warnings about incorrect address space)

but without this patch. So it would be great if we could have it in 3.5.
Or alternatively revert 5775ba3. This fix currently it sits as

	096bcc2 (mtd: mxc_nand: use 32bit copy functions)

in next/master.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
