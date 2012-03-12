From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 14:06:20 +0000
Subject: mfd: mc13xxx: add I2C support, V2
In-Reply-To: <20120311115018.GA16825@pengutronix.de>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
 <20120311115018.GA16825@pengutronix.de>
Message-ID: <20120312140620.GB14020@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 12:50:18PM +0100, Wolfram Sang wrote:

> free, if this is desired. I think the regmap approach should have been tried
> before we go custom. sound/soc/codecs/ad193x.c might give an impression how
> regmap spi/i2c in one driver could look like.

There's a bunch of other examples in sound/soc and also the wm831x PMIC
driver in drivers/mfd.  For an initial conversion I'd not worry about
the cache, especially with some of the older PMICs hardware designers
were known to come up with some "innovative usability solutions" which
can cause hassle.
