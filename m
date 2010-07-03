From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Jul 2010 01:15:40 +0100
Subject: [alsa-devel] [PATCH 1/2] ASoC: Add SmartQ sound driver
In-Reply-To: <4c2e7f3e.887b0e0a.5935.3f95@mx.google.com>
References: <4c2e7f3e.887b0e0a.5935.3f95@mx.google.com>
Message-ID: <20100703001539.GA3869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2010 at 06:23:14PM +0100, Maurus Cuelenaere wrote:

Might want to check your mail setup - the date looks wrong.

> This adds sound support for the SmartQ board.
> 
> The hardware consists of a S3C6410 coupled with a WM8987 over I?S. As there's
> no driver for the WM8987 currently, this uses the WM8750 driver (which should
> be register compatible).

There's no need to add a separate driver for a register compatible part,
just add the I2C/SPI IDs to the existing driver.  Otherwise we just
duplicate it redundantly.  Please update this and the comment in the
driver to reflect that.

Otherwise this looks OK, but there's a couple of things that it'd be
nice to update:

> +	dev_info(&smartq_snd_device->dev, "SmartQ WM8987 audio driver inited\n");

Best to remove this, it gets a bit noisy.

> +MODULE_AUTHOR("Maurus Cuelenaere");

Better to add your mail address too.
