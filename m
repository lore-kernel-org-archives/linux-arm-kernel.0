From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 16:20:02 +0100
Subject: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <1343003.MpQlxoEPa6@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<20111003134527.GF11710@n2100.arm.linux.org.uk>
	<20111003143553.GG23811@sirena.org.uk> <1343003.MpQlxoEPa6@wuerfel>
Message-ID: <20111003152002.GP3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 04:47:07PM +0200, Arnd Bergmann wrote:

> sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete element type

OK, that's the gpio_request_ stuff not being implemented thing that I
have seen some reports of.  Looks like that's not been stubbed out, but
for Prima2 the best fix is just to turn on gpiolib since there's no
excuse for a new platform to not use it.
