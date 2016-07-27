From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 27 Jul 2016 09:55:11 +0800
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160726192609.GA27782@weiser.dinsnail.net>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather> <20160722135658.GA18977@weiser.dinsnail.net>
 <20160725122522.GL7419@lukather> <20160726192609.GA27782@weiser.dinsnail.net>
Message-ID: <CAGb2v67O5vrqN4m3rZVBGA+ee1bg2iTxiggNJF+t5Lszd=mW=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 3:26 AM, Michael Weiser <michael.weiser@gmx.de> wrote:
> Hi Maxime,
>
> On Mon, Jul 25, 2016 at 02:25:22PM +0200, Maxime Ripard wrote:
>
>> > via I2C. I have not deliberately/synthetically tested the DMA engine. It's
>> > enabled in the my kernel config and seems happy but was not selected by
>> > any other driver so seems to be unused currently.
>> You can test the DMA using the audio components, either the codec, i2s
>> or spdif.
>
> I've enabled the codec and it's currently playing some King Khan to me.
> From looking at sun4i-dma.c it seems that all communication with the
> silicon is via registers, including transfer of the DMA descriptors, and
> all is done using {read,write}l{,_relaxed} already.
>
>> EMAC would be worth testing too.
>
> As far as I gather, the Cubieboard2 does not route the EMAC pins anywhere.
> So I can't connect a PHY to it for testing.

The EMAC pins are muxed with the GMAC pins. All you need to do is disable
the GMAC, enable the EMAC, and use emac_pins_a for the pinctrl.

ChenYu
