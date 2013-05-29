From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 May 2013 15:49:09 +0100
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <201305291526.35099.arnd@arndb.de>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <1369817353.993218858@f175.mail.ru>
 <20130529112002.GS3660@sirena.org.uk>
 <201305291526.35099.arnd@arndb.de>
Message-ID: <20130529144909.GT3660@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 03:26:34PM +0200, Arnd Bergmann wrote:
> On Wednesday 29 May 2013, Mark Brown wrote:

> > We probably also want to make
> > GPIO chip select support a standard thing that's available with every
> > driver rather than something the driver has to know about but that's a
> > separate bit of work.

> That actually seems simpler than doing it in just one driver: if
> we add a cs_gpio field to spi_board_info, spi_new_device could
> just copy that information into the new spi_device instead of
> taking it from master->cs_gpios.

Yeah, that bit of it is fine and straightforward.  It's slightly more
work to factor the chip select handling out so that we can implement the
handling at the appropriate moments in the flow due to the fact that
it's embedded in the message transfer functions but totally doable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/73ebb588/attachment-0001.sig>
