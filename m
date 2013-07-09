From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 15:55:10 +0100
Subject: MTD EEPROM support and driver integration
In-Reply-To: <20130708202538.GK11243@lukather>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
 <20130708083426.GO27646@sirena.org.uk>
 <20130708202538.GK11243@lukather>
Message-ID: <20130709145510.GZ27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 10:25:38PM +0200, Maxime Ripard wrote:
> On Mon, Jul 08, 2013 at 09:34:26AM +0100, Mark Brown wrote:

> > I'd really like to see more discussion of this "DT parsing code for
> > regmap" idea...  I've missed almost all the context here.

> The context was that I found we lack a way to simply express the need
> for one driver to get a value from an EEPROM-like device, for example to
> get a MAC Address, or a serial number, in a generic way, without having
> to poke directly with some custom function that would be exported by the
> EEPROM driver.

This sort of information is often stored in places like flash partitions
too.  Are we sure that regmap is a good place to be hooking in here?
The use case is sane, and being able to use regmap to do some of it
seems sensible (I've seen people use OTP in PMICs for similar purposes)
but perhaps an additional layer of abstraction on top makes sense.

> What we've been discussing so far is that:
>   - To have a common framework we could base our work on, we could move
>     the EEPROM drivers from drivers/misc/eeprom to MTD
>   - To declare the ranges that needed to be used by a driver that was
>     needing a value from one of those MTD drivers, we would use regmap
>     with a MTD backend
>   - And since we actually need to declare which ranges and in which
>     device one driver would have to retrieve this value from, we were
>     actually in need of DT bindings.

> This is pretty much the only context involved, and we are at the early
> stage of the discussion, so any comment is very welcome :)

If this stuff is being represented in MTD doesn't MTD already have
adequate abstractions for saying "this region in flash".  But otherwise
this seems fine, it's not a generic regmap DT binding but instead rather
more specific than that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/bc394b59/attachment.sig>
