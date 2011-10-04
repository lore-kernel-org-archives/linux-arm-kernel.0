From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 17:22:28 -0600
Subject: [PATCH v2 6/7] clk: Add initial WM831x clock driver
In-Reply-To: <20111004205002.GA20296@opensource.wolfsonmicro.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-7-git-send-email-mturquette@ti.com>
	<20110925040836.GP24631@ponder.secretlab.ca>
	<20110926093858.GD2946@opensource.wolfsonmicro.com>
	<20111004181818.GD2870@ponder.secretlab.ca>
	<20111004205002.GA20296@opensource.wolfsonmicro.com>
Message-ID: <20111004232228.GA3009@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 09:50:02PM +0100, Mark Brown wrote:
> On Tue, Oct 04, 2011 at 12:18:18PM -0600, Grant Likely wrote:
> > #define module_platform_driver(__driver) \
> > int __driver##_init(void) \
> > { \
> > 	return platform_driver_register(&(__driver)); \
> > } \
> > module_init(__driver##_init); \
> > void ##__driver##_exit(void) \
> > { \
> > 	platform_driver_unregister(&(__driver)); \
> > } \
> > module_exit(##__driver##_exit);
> 
> > It's not a lot of code, but I dislike how much boilerplate every
> > single driver has to use if it doesn't do anything special.
> 
> Yeah, this sort of stuff would be helpful - there's quite a bit of
> boilerplate you end up having to write to get drivers going.

Draft patch written, and posting to the list soon...

g.
