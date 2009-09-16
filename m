From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 11:22:10 +0100
Subject: [PATCH 02/10] S3C64XX I2S: declared i2s_v4
In-Reply-To: <20090916001220.GC24720@trinity.fluff.org>
References: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
	<20090916001220.GC24720@trinity.fluff.org>
Message-ID: <20090916102210.GB3589@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 01:12:20AM +0100, Ben Dooks wrote:
> On Tue, Sep 15, 2009 at 07:02:34PM +0900, Jassi wrote:

> > -	.id		  = -1,
> > +	.name		  = "s3c64xx-iis",
> > +	.id		  = 2,

> I'd like to see how much different the two drivers are, and whether they
> need to be seperated into their own modules.

There's substantial overlap (mostly IISv4 just adds new register bits to
control the additional channels), but the trick would be how the driver
is supposed to work out that it's handling an IISv4 device and enable
the additional functionality.

> Changing the name to s3c64xx-iis means that the module auto-load may end
> up loading the wrong module. Holding off on this change until we se what
> needs to be done for this block.

It's certainly not a long-term solution as-is.
