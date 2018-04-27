From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 27 Apr 2018 12:20:33 +0200
Subject: [PATCH 20/61] input: keyboard: simplify getting .drvdata
In-Reply-To: <20180426212327.GB210716@dtor-ws>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
 <20180426200401.lvqiy4gnchkwr4qw@ninjato>
 <20180426212327.GB210716@dtor-ws>
Message-ID: <20180427102033.msrr5sourxrtypg7@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> > Isn't it actually the other way around? platform_get_drvdata() is a
> > convenience function to access driver_data which is embedded in struct
> > device?
> 
> I guess it depends on how you read it. I always considered it separate
> because none (?) of the bus implementation assert this in comments to
> XXX_get_drvdata().

Well, even in the case somebody will implement a custom driver_data for
platform_devices, this person will need to convert all current users to
'dev_get_drvdata(&pdev->dev);' first in order to avoid regressions, I'd
think. This is what my patch does right now (but merely for overhead
reasons). Or?

> > > in the future, so I'd prefer keep using the proper accessors for the
> > > objects we are dealing with.
> > 
> > Exactly. I'd just argue, the object we are dealing with, declared in the
> > PM functions, is a struct device.
> 
> No, the driver does not create a generic device, it actually creates a
> platform device, or i2c client, or spi, or something else. The fact that

True.

> suspend and resume routines have generic device as their argument has
> more to do with the language limitation rather than reflection of true
> type of the objects we are dealing with.

Ok, can be argued. I'd personally still go for the gain, but I won't
push harder than this mail.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180427/c040aa09/attachment.sig>
