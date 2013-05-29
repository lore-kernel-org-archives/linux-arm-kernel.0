From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 May 2013 12:20:02 +0100
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <1369817353.993218858@f175.mail.ru>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <1743419.NY2Q01i8Iq@wuerfel> <1369817353.993218858@f175.mail.ru>
Message-ID: <20130529112002.GS3660@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 12:49:13PM +0400, Alexander Shiyan wrote:
> > On Wednesday 29 May 2013 10:42:22 Alexander Shiyan wrote:

> > Wouldn't it be better to kill off the platform_data for these drivers
> > and pass the gpio number through spi->controller_data as the
> > spi_gpio driver does?

> Interesting way. Just one question remains, for using not-dt variant,
> how  we should specify num_chipselect parameter for master?
> I see only way for specify maximum constant in the driver.

We should fix that to be dynamic, having a fixed number is not sensible
when GPIOs are usable for chip select.  We probably also want to make
GPIO chip select support a standard thing that's available with every
driver rather than something the driver has to know about but that's a
separate bit of work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/a1431524/attachment.sig>
