From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Oct 2011 14:45:27 +0100
Subject: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <20111002204106.GB5811@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
Message-ID: <20111003134527.GF11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 09:41:07PM +0100, Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> > This driver only builds correctly on platforms that use
> > GPIOLIB. Disable it otherwise.
> 
> No, gpiolib is one implementation of the GPIO API but if platforms want
> to go and define their own that's currently OK (personally I think at
> this point we should just be converting all the stragglers over to
> gpiolib).  As things stand we shouldn't have dependencies on a
> particular implementation of the API.

Then it should depend on GENERIC_GPIO (not to be confused with GPIO_GENERIC,
the generic gpiolib driver), which is the symbol meaning that the GPIO API
is provided by something.
