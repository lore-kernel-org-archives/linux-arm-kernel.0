From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 9 Nov 2012 15:55:04 +0100
Subject: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
In-Reply-To: <20121109143841.GG23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
 <20121109143841.GG23807@opensource.wolfsonmicro.com>
Message-ID: <20121109145504.GC8598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 02:38:42PM +0000, Mark Brown wrote:
> On Fri, Nov 09, 2012 at 03:00:23PM +0100, Steffen Trumtrar wrote:
> 
> > The wm8974 can be controlled via i2c or spi. The current driver only supports
> > i2c. Add SPI as possible bus.
> > 
> > As the driver has to distinguish the bus type, pass this info via the wm8974_priv.
> > This reverts c2562a8e3b5f871ad0b73caf98bb7541e8724efc, because the driver now
> > needs it back.
> 
> Don't just quote raw commit IDs, *especially* not full ones, as they're
> completely illegible to humans.  Someone reading the changelog needs to
> be able to understand what this commit is and why the driver needs it
> back.
> 

Okay.

> > -	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
> > +	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8974->control_type);
> 
> We should be converting things to regmap if we're going to do this -
> we're trying to phase out the ASoC-specific I/O and this makes the code
> simpler anyway as the core will just be able to get the regmap from the
> struct device without bouncing information around through the private
> data and so on.

I wasn't aware of that driver. That sounds way better than the private data stuff.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
