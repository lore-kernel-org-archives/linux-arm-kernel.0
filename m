From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 11:58:08 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <AANLkTin9qGAJGSgu9Y2YjI_W8UwBITd-QYyGERcLLUgP@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100610090015.GD3422@pengutronix.de>
	<AANLkTin9qGAJGSgu9Y2YjI_W8UwBITd-QYyGERcLLUgP@mail.gmail.com>
Message-ID: <20100610095808.GA31057@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

> > What do you think about requiring r4 to be set to physoffset as I did in
> > my series?
> 
> My only concern is to impose less restrictions on the boot loaders.
While it remains optional without runtime physoffset it's OK if you ask
me.

> And zImage is only one of the possible headers we may have:
> 
>  * vmlinux can actually directly booted into as long as it's placed at the
>    right place
>  * uImage, with zImage or vmlinux (raw or compressed) encapsulated
>  * zImage
>  * xipImage
>  * bootpImage
bootpimage is still used?  In a different thread I suggested to remove
it.
The others are just a wrapped vmlinux that needs to be aware anyhow.
And the wrappers only need to pass r4 additionally to r2 and r3 through.

> I'd really like to separate the guess work into two parts so they don't
> have dependencies.
But zreladdr is always physoffset + textoffset, isn't it?  So you should
use the same guess for both physoffset and zreladdr, no?

And if you do it properly, it should even be possible to reuse the same
code for all locations.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
