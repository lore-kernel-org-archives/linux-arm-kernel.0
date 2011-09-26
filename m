From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Sep 2011 10:38:58 +0100
Subject: [PATCH v2 6/7] clk: Add initial WM831x clock driver
In-Reply-To: <20110925040836.GP24631@ponder.secretlab.ca>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-7-git-send-email-mturquette@ti.com>
	<20110925040836.GP24631@ponder.secretlab.ca>
Message-ID: <20110926093858.GD2946@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 10:08:36PM -0600, Grant Likely wrote:
> On Thu, Sep 22, 2011 at 03:27:01PM -0700, Mike Turquette wrote:

> > +	ret = platform_driver_register(&wm831x_clk_driver);
> > +	if (ret != 0)
> > +		pr_err("Failed to register WM831x clock driver: %d\n", ret);
> > +
> > +	return ret;

> No need for this song-and-dance.  The driver core is pretty well
> debugged.  Just use "return platform_driver_register(...);"

No, that's not helpful.  The issue isn't the device probe code itself,
the issue is things like module unload not doing what they're supposed
to do and leaving the device lying around or something - there's rather
more going on than just the plain API call.
