From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 12:56:18 +0100
Subject: [PATCH 08/10] S3C64XX I2S: Return correct codec clock
In-Reply-To: <1b68c6790909150421y7c78ad8dt2703bd039fcd39b@mail.gmail.com>
References: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
	<20090915110635.GI22878@rakim.wolfsonmicro.main>
	<1b68c6790909150421y7c78ad8dt2703bd039fcd39b@mail.gmail.com>
Message-ID: <20090915115618.GN22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 08:21:05PM +0900, jassi brar wrote:
> On Tue, Sep 15, 2009 at 8:06 PM, Mark Brown

> > There's three possible clocks here according to the datasheet - PCLK,
> > CLKAUDIO and I2SCLK - so this will still give the wrong clock some of
> > the time. ?Also, please use checkpatch

> Yes, but the existing code doesn't consider I2SCLK at all.
> The infra isn't there to provide the clock pointer anyhow.

Please put a comment there explaining that, or ideally code that returns
an error in those cases, to make it clearer what's being done.
