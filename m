From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Aug 2012 10:09:09 +0800
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <CAKGA1bmMqyL4gyLYcanEH=R=HuBjRCNRLjUEWCj8wmpi3HuL0g@mail.gmail.com>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
 <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
 <20120806154951.GQ16861@opensource.wolfsonmicro.com>
 <CAKGA1b=_AOub_pEJJGBTb6Y7wLZaSYKQjFTyMVFSr_=9VX4wpg@mail.gmail.com>
 <20120806193734.GA16199@opensource.wolfsonmicro.com>
 <20120806201609.GX25644@pengutronix.de>
 <CAKGA1bmMqyL4gyLYcanEH=R=HuBjRCNRLjUEWCj8wmpi3HuL0g@mail.gmail.com>
Message-ID: <20120807020907.GB24289@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 03:39:50PM -0500, Matt Sealey wrote:
> * make sure there's no weird FIQ stuff floating around that has so far
> relied on SND_SOC_IMX_PCM_FIQ doing select FIQ before I make it not

Acked on changing SND_IMX_SOC to SND_SOC_IMX_PCM_FIQ in
arch/arm/plat-mxc/Makefile.

> compile in for other boards (since otherwise no i.MX processor selects
> FIQ if they're not using that driver, it could be simply coincidence
> nobody noticed). I don't want to be the one submitting a patch I can't
> test which mysteriously breaks every MX28 on the planet (since Rob,
> Shawn, Sascha might be the ones swearing at me instead)
> 
Though i.MX23 and i.MX28 are named in i.MX family, they are actually
a different architecture from IMX/MXC.  It's MXS, nothing to do with
SSI.  Folder sound/soc/mxs/ is the one for i.MX28.

-- 
Regards,
Shawn
