From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Jun 2017 09:41:26 +0200
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170620025815.GA4818@x250>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250>
Message-ID: <20170620074126.GA1541@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> Oh, yes, I should have mentioned it in the cover-letter.  Instead of
> changing MAINTAINERS file in different subsystem patch series, which may
> introduce merge conflicts, we plan to update it with a separate patch
> adding all driver entries that lands on mainline, and get it in through
> arm-soc tree.  Are you okay with that?

Yup, totally fine! Good approach.

> > Is this the error handling (NACK, etc)? Then, it got lost now since we
> > don't reset the hardware anymore after timeouts. But that would have
> > meant that errors are only detected after the timeout was reached
> > instead of instantly? If so, no good design. But maybe I misunderstand.
> 
> Hmm, this doesn't make too much sense now, since this reset function is
> only being called at probe time to ensure the device is in a sane
> initial state.  There is no data transfer happening at this point at
> all.  I will drop these error bits checking from here, and add the error
> handling in irq handler.

Great, thanks!

> > How was this driver tested BTW?
> 
> The driver is being used to access an Audio codec on the I2C bus.

Nice. Can you also run 'i2cdetect' on the bus to see if we have proper
NAK handling? AFAICS this should be broken now. And very slow with
previous versions of the driver.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/997f5aa4/attachment.sig>
