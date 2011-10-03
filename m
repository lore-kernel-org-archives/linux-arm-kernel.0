From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 17:34:41 +0100
Subject: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <9353092.2X2OeIUYGE@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1343003.MpQlxoEPa6@wuerfel>
	<20111003152002.GP3731@opensource.wolfsonmicro.com>
	<9353092.2X2OeIUYGE@wuerfel>
Message-ID: <20111003163441.GH23811@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 06:19:48PM +0200, Arnd Bergmann wrote:

> When the GPIO API is stubbed out, the definition of struct gpio
> is empty, so you cannot access the members, which seems to be
> intentional behavior.

That doesn't seem terribly helpful, it means drivers either need to
ifdef or not use the bulk functions.

>  struct device;
> -struct gpio;
> +struct gpio {
> +       unsigned        gpio;
> +       unsigned long   flags;
> +       const char      *label;
> +};

This looks much more sensible to me.

>  	select SND_SOC_WL1273 if MFD_WL1273_CORE
> -	select SND_SOC_WM1250_EV1 if I2C
> +	select SND_SOC_WM1250_EV1 if I2C && GENERIC_GPIO

Or ifdefs in the driver.
