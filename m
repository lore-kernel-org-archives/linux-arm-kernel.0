From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 29 May 2013 21:05:59 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gU1BJOiBVbmlmeSBzaW1wbGUgcGxhdGZvcm0gZGF0YSBm?=
 =?UTF-8?B?b3Igc29tZSBjb250cm9sbGVycw==?=
In-Reply-To: <20130529144909.GT3660@sirena.org.uk>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <201305291526.35099.arnd@arndb.de>
 <20130529144909.GT3660@sirena.org.uk>
Message-ID: <1369847158.250798748@f433.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, May 29, 2013 at 03:26:34PM +0200, Arnd Bergmann wrote:
> > On Wednesday 29 May 2013, Mark Brown wrote:
> 
> > > We probably also want to make
> > > GPIO chip select support a standard thing that's available with every
> > > driver rather than something the driver has to know about but that's a
> > > separate bit of work.
> 
> > That actually seems simpler than doing it in just one driver: if
> > we add a cs_gpio field to spi_board_info, spi_new_device could
> > just copy that information into the new spi_device instead of
> > taking it from master->cs_gpios.
> 
> Yeah, that bit of it is fine and straightforward.  It's slightly more
> work to factor the chip select handling out so that we can implement the
> handling at the appropriate moments in the flow due to the fact that
> it's embedded in the message transfer functions but totally doable.

Initial try to simplify i.MX SPI driver I will send in 5 min.
Patches is untested, so it is only RFC. Platform data still present in
driver but patch migrate driver to using dynamic counter of
chipselects for dt-case. Is it true way now? Comments are welcome.
Thanks.

---
