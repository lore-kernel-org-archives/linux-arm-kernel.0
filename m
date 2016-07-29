From: michael.weiser@gmx.de (Michael Weiser)
Date: Fri, 29 Jul 2016 09:59:23 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <CAGb2v67O5vrqN4m3rZVBGA+ee1bg2iTxiggNJF+t5Lszd=mW=A@mail.gmail.com>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather>
 <20160722135658.GA18977@weiser.dinsnail.net>
 <20160725122522.GL7419@lukather>
 <20160726192609.GA27782@weiser.dinsnail.net>
 <CAGb2v67O5vrqN4m3rZVBGA+ee1bg2iTxiggNJF+t5Lszd=mW=A@mail.gmail.com>
Message-ID: <20160729075923.GE415@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu,

On Wed, Jul 27, 2016 at 09:55:11AM +0800, Chen-Yu Tsai wrote:
> > As far as I gather, the Cubieboard2 does not route the EMAC pins anywhere.
> > So I can't connect a PHY to it for testing.
> The EMAC pins are muxed with the GMAC pins. All you need to do is disable
> the GMAC, enable the EMAC, and use emac_pins_a for the pinctrl.

Okay, I've done that by copying the relevant dts sections from
sun4i-a10-cubieboard.dts. It initialises and transmits packets fine. But
it doesn't seem to accept incoming packets. I suspect that programming
of its own MAC address (which the driver chooses randomly) suffers from
an endianness issue. I'm somewhat stumped as to what is causing it since
all accesses use {read,write}l. Interrupt handling is another possible
culprit. I'm still digging.
-- 
Thanks,
Michael
