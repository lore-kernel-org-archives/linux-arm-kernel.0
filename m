From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 21:41:07 +0100
Subject: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <1317587284-2776-3-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
Message-ID: <20111002204106.GB5811@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> This driver only builds correctly on platforms that use
> GPIOLIB. Disable it otherwise.

No, gpiolib is one implementation of the GPIO API but if platforms want
to go and define their own that's currently OK (personally I think at
this point we should just be converting all the stragglers over to
gpiolib).  As things stand we shouldn't have dependencies on a
particular implementation of the API.
