From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 11 Mar 2013 20:56:07 +0100
Subject: [PATCH 06/10] ARM: soc-audio phycore-ac97: fix driver init order
In-Reply-To: <20130311111011.GA10617@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
 <20130311111011.GA10617@opensource.wolfsonmicro.com>
Message-ID: <20130311195607.GD18350@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 11:10:11AM +0000, Mark Brown wrote:
> On Sun, Mar 10, 2013 at 07:33:07PM +0100, Markus Pargmann wrote:
> > Adding a soc-audio sound driver internally uses snd_soc_register_device,
> > which tries to bind it with the codec. The adding of the driver is
> > deferred because the codec driver is not loaded.
> 
> > This patch changes the order of registration. The codec driver is there
> > before the ac97 driver, so the snd_soc_register_device call is
> > successfull.
> 
> You shouldn't be using soc-audio in the first place...

Yes. This is just a fixup of the old "driver" part.
The new DT driver does not use soc-audio (added in patch 7)

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
