From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 18 Aug 2010 13:30:53 +0100
Subject: [PATCH 01/06] pxa3xx_nand: update ns2cycle calculation method
In-Reply-To: <AANLkTikzdVAwOZcLhgHsDQGNhW4_-420XodbxSUmfDRW@mail.gmail.com>
References: <AANLkTikzdVAwOZcLhgHsDQGNhW4_-420XodbxSUmfDRW@mail.gmail.com>
Message-ID: <1282134653.13405.15.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-17 at 13:29 +0100, Haojian Zhuang wrote:
> From 9064b2c877cad560fda7577564b3369c0025b7df Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Tue, 17 Aug 2010 17:24:06 +0800
> Subject: [PATCH 01/06] pxa3xx_nand: update ns2cycle calculation method
> 
> For the original method change from plus 1 to minus 1,
> this way make the default timing like tCS become 0 after calculation,
> although we set the timing as 0xa...
> 
> Change the method to no plus and minus, and make the result
> closer to what the timing specified in the NAND chip spec.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>

I have an identical patch queued for -stable and 2.6.36 already, from
Axel Lin (but with a slightly better changelog).

I'll add your signed-off-by to that and send it on today.

The other five I'll apply to the mtd-2.6.git on top, once I have Eric's
ack.

Thanks.

By the way, please could you use my dwmw2 at infradead.org address instead
of @intel.com -- the latter has taken to corrupting incoming mail again,
and they're being extremely slow to fix it.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
