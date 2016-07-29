From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Jul 2016 18:39:07 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160729075923.GE415@weiser.dinsnail.net>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather>
 <20160722135658.GA18977@weiser.dinsnail.net>
 <20160725122522.GL7419@lukather>
 <20160726192609.GA27782@weiser.dinsnail.net>
 <CAGb2v67O5vrqN4m3rZVBGA+ee1bg2iTxiggNJF+t5Lszd=mW=A@mail.gmail.com>
 <20160729075923.GE415@weiser.dinsnail.net>
Message-ID: <20160729163907.GD6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 29, 2016 at 09:59:23AM +0200, Michael Weiser wrote:
> Hi ChenYu,
> 
> On Wed, Jul 27, 2016 at 09:55:11AM +0800, Chen-Yu Tsai wrote:
> > > As far as I gather, the Cubieboard2 does not route the EMAC pins anywhere.
> > > So I can't connect a PHY to it for testing.
> > The EMAC pins are muxed with the GMAC pins. All you need to do is disable
> > the GMAC, enable the EMAC, and use emac_pins_a for the pinctrl.
> 
> Okay, I've done that by copying the relevant dts sections from
> sun4i-a10-cubieboard.dts. It initialises and transmits packets fine. But
> it doesn't seem to accept incoming packets. I suspect that programming
> of its own MAC address (which the driver chooses randomly) suffers from
> an endianness issue. I'm somewhat stumped as to what is causing it since
> all accesses use {read,write}l. Interrupt handling is another possible
> culprit. I'm still digging.

Maybe a good way to confirm that would be to generate outgoing
traffic, dump that and see what the mac address is? If it's not
programmed properly, you should see it in the packets.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/ba256feb/attachment-0001.sig>
