From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 26 Apr 2018 22:04:01 +0200
Subject: [PATCH 20/61] input: keyboard: simplify getting .drvdata
In-Reply-To: <20180426191947.GC162443@dtor-ws>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
Message-ID: <20180426200401.lvqiy4gnchkwr4qw@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
> 
> I consider the fact that platform device's driver data is accessible via
> device driver data being implementation detail that may or may not change

Isn't it actually the other way around? platform_get_drvdata() is a
convenience function to access driver_data which is embedded in struct
device?

> in the future, so I'd prefer keep using the proper accessors for the
> objects we are dealing with.

Exactly. I'd just argue, the object we are dealing with, declared in the
PM functions, is a struct device.

Thanks for the comment,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/dce32dd3/attachment.sig>
