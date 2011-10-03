From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 15:35:53 +0100
Subject: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <20111003134527.GF11710@n2100.arm.linux.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
	<20111003134527.GF11710@n2100.arm.linux.org.uk>
Message-ID: <20111003143553.GG23811@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 02:45:27PM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 09:41:07PM +0100, Mark Brown wrote:

> > No, gpiolib is one implementation of the GPIO API but if platforms want
> > to go and define their own that's currently OK (personally I think at
> > this point we should just be converting all the stragglers over to
> > gpiolib).  As things stand we shouldn't have dependencies on a
> > particular implementation of the API.

> Then it should depend on GENERIC_GPIO (not to be confused with GPIO_GENERIC,
> the generic gpiolib driver), which is the symbol meaning that the GPIO API
> is provided by something.

Not for devices like this where the GPIOs are an optional thing the
driver can use, a dependency is far too strong.  Devices like that
should be able to rely on the stubs.
