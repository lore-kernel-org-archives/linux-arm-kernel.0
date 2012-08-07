From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Aug 2012 17:50:20 +0100
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <20120807063558.GE1451@pengutronix.de>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
 <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
 <20120806154951.GQ16861@opensource.wolfsonmicro.com>
 <CAKGA1b=_AOub_pEJJGBTb6Y7wLZaSYKQjFTyMVFSr_=9VX4wpg@mail.gmail.com>
 <20120806193734.GA16199@opensource.wolfsonmicro.com>
 <20120806201609.GX25644@pengutronix.de>
 <CAKGA1bmMqyL4gyLYcanEH=R=HuBjRCNRLjUEWCj8wmpi3HuL0g@mail.gmail.com>
 <20120806214121.GA26698@opensource.wolfsonmicro.com>
 <20120807063558.GE1451@pengutronix.de>
Message-ID: <20120807165019.GT16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 08:35:58AM +0200, Sascha Hauer wrote:

> Nowadays the FIQ support is necessary only for AC97. The AC97 support in
> the SSI unit is buggy: It does not allow you to select the slots you
> want to receive. At least the wm9712 codec always sends (apart from the
> stereo data) data in slot (I think it is) 12. You find this data mixed
> in your audio stream. The FIQ driver skips this data to get a valid
> audio stream.

Right, any device with GPIO support will do this - it's how GPIO works
in AC'97.

> One other way to solve this would be to use dma here and to filter out
> the data afterwards.

Yup.  That's probably more sane but also more work to implement.
