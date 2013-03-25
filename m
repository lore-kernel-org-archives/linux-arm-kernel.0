From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 13:15:58 +0000
Subject: EXYNOS will support only DT from v3.10
In-Reply-To: <20130325130951.GQ18316@opensource.wolfsonmicro.com>
References: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
 <201303251237.38782.arnd@arndb.de>
 <20130325130951.GQ18316@opensource.wolfsonmicro.com>
Message-ID: <201303251315.58347.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Mark Brown wrote:
> On Mon, Mar 25, 2013 at 12:37:38PM +0000, Arnd Bergmann wrote:
> 
> > We don't have any DT support for S3C and S5P upstream yet, so I would
> > certainly agree on that. I think we should plan at least one release of
> > supporting both simultaneously in order to find bugs with the DT
> > implementation before we can consider removing ATAGS support for any
> > major platform.
> 
> We really ought to look into fixing the bootloader protocol to allow
> ATAGS and DT simultaneously BTW, the current situation is a pain
> especially if you need uImage.

I think the plan at the moment is to extend the atags wrapper to allow
picking one out of multiple device tree blobs, which matches the
machine ID, rather than having to know the right one in advance.

	Arnd
