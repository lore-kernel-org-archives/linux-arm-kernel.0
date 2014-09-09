From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 18:20:57 +0100
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <540F3447.3020609@ti.com>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk> <540F3447.3020609@ti.com>
Message-ID: <20140909172057.GH2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 01:09:27PM -0400, Murali Karicheri wrote:
> On 09/09/2014 12:55 PM, Mark Brown wrote:
> >On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:

> >>- ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
> >>	(SPIDELAY.C2TDELAY)

> >>- ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
> >>	(SPIDELAY.T2CDELAY)

> >Now I look at these they look very much like the standard delay feature
> >that the SPI subsystem has already - are they?

> As Grygorii explained in previous postings (reproduced below), these delays
> are handled by the SPI hardware on Keystone and affect the delay between
> successive word tranmssion and has nothing to do with the delay you are
> talking about. Isn't the standard delay you mention here is between
> successive packets send down to the lower level driver (in this case
> spi-davinci.c) ?

He talked about such delays between words (and there were some other
delays listed which seemed to meet that description) but the above don't
appear to refer to them, the above refer to delays around chip select
which most definitely are covered with the standard delays.

If these delays are not related to chip select then the documentation
needs to be fixed to not refer to chip select.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/ce792e6d/attachment.sig>
