From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Sep 2009 13:22:10 +0100
Subject: something wrong in drivers/power
In-Reply-To: <20090928075517.GA6871@doriath.ww600.siemens.net>
References: <20090926095555.GG1331@ucw.cz>
	<20090926145536.GA8445@doriath.ww600.siemens.net>
	<20090927173516.GB6710@elf.ucw.cz>
	<20090928075517.GA6871@doriath.ww600.siemens.net>
Message-ID: <20090928122210.GB32420@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:55:17AM +0400, Dmitry Eremin-Solenikov wrote:

> 1) add a clean possibility to pass platform data via ac97 bus to wm97xx
> core driver (care to check that it should be passable both via regular
> ac97 driver and via ASoC).

This has already been done by Marek, I think most of the bits made it
into 2.6.32-rc1 though I haven't checked.  The problem had been getting
ALSA support for using the platform data but Takashi agreeded to that so
we're fine.  It needs explict support in the AC97 controller driver to
actually set the platform data for the CODECs on the bus but that's been
done for PXA.

In any case, I'd nack the original patch too - all it will do is break
the driver since it will no longer load and the attempts to get the
wm97xx structure from the parent device of a separately registered
platform device will oops.
