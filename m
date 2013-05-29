From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 20:10:05 +0200
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <1369847158.250798748@f433.i.mail.ru>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <20130529144909.GT3660@sirena.org.uk> <1369847158.250798748@f433.i.mail.ru>
Message-ID: <1962597.10ArYKg8M9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013 21:05:59 Alexander Shiyan wrote:
> > On Wed, May 29, 2013 at 03:26:34PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 29 May 2013, Mark Brown wrote:
> > 
> > > > We probably also want to make
> > > > GPIO chip select support a standard thing that's available with every
> > > > driver rather than something the driver has to know about but that's a
> > > > separate bit of work.
> > 
> > > That actually seems simpler than doing it in just one driver: if
> > > we add a cs_gpio field to spi_board_info, spi_new_device could
> > > just copy that information into the new spi_device instead of
> > > taking it from master->cs_gpios.
> > 
> > Yeah, that bit of it is fine and straightforward.  It's slightly more
> > work to factor the chip select handling out so that we can implement the
> > handling at the appropriate moments in the flow due to the fact that
> > it's embedded in the message transfer functions but totally doable.
> 
> Initial try to simplify i.MX SPI driver I will send in 5 min.
> Patches is untested, so it is only RFC. Platform data still present in
> driver but patch migrate driver to using dynamic counter of
> chipselects for dt-case. Is it true way now? Comments are welcome.

The plan for i.MX is to move to DT-only in the long run, but
AFAIK a lot of people still rely on board files and they are
not trivial to convert without access to test hardware.

Any new i.MX hardware should certainly be DT-only.

Shawn can probably comment better on the time line.

	Arnd
