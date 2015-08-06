From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 12:23:53 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
References: <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
Message-ID: <20150806112353.GT20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:

> However, I am familiar m25p80.c and as I understand it the controller
> is basically supposed to implement m25p80.c in hardware when this flag
> is set.

But what in concrete terms is that supposed to mean?  It's currently
just an essentially undocumented flag on a message rather than something
operating at the level of a flash chip.  That's pretty much where
Russell's comments come from.

> If I was using m25p80.c to talk to anything but an actual flash chip
> it would get me quite worried.

Sure, but at the end of the day it's just emitting standard SPI messages
which don't know anything about flash.  If those messages are a sensible
interface here then why bother with the flag, we can just pattern match
on the format of the message.  If that doesn't work then probably this
isn't a great interface and a separate, application specific interface
makes more sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/3c0b0c61/attachment.sig>
