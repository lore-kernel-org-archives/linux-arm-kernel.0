From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 26 Apr 2018 14:23:27 -0700
Subject: [PATCH 20/61] input: keyboard: simplify getting .drvdata
In-Reply-To: <20180426200401.lvqiy4gnchkwr4qw@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
 <20180426200401.lvqiy4gnchkwr4qw@ninjato>
Message-ID: <20180426212327.GB210716@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:04:01PM +0200, Wolfram Sang wrote:
> Hi Dmitry,
> 
> > > We should get drvdata from struct device directly. Going via
> > > platform_device is an unneeded step back and forth.
> > 
> > I consider the fact that platform device's driver data is accessible via
> > device driver data being implementation detail that may or may not change
> 
> Isn't it actually the other way around? platform_get_drvdata() is a
> convenience function to access driver_data which is embedded in struct
> device?

I guess it depends on how you read it. I always considered it separate
because none (?) of the bus implementation assert this in comments to
XXX_get_drvdata().

> 
> > in the future, so I'd prefer keep using the proper accessors for the
> > objects we are dealing with.
> 
> Exactly. I'd just argue, the object we are dealing with, declared in the
> PM functions, is a struct device.

No, the driver does not create a generic device, it actually creates a
platform device, or i2c client, or spi, or something else. The fact that
suspend and resume routines have generic device as their argument has
more to do with the language limitation rather than reflection of true
type of the objects we are dealing with.

Thanks.

-- 
Dmitry
