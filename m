From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 12:59:47 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FECB7A.6010208@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com>
Message-ID: <20130805115947.GA9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 11:45:30PM +0200, Sebastian Hesselbarth wrote:
> On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:

> >                 .name = "S/PDIF1",
> >                 .stream_name = "IEC958 Playback",
> >                 .platform_name = "mvebu-audio.1",
> >                 .cpu_dai_name = "mvebu-audio.1",
> >                 .codec_dai_name = "dit-hifi",
> >                 .codec_name = "spdif-dit",

> Not a big deal for DT. I suggest to have a "audio-codecs" property that
> link CPU DAI to codec(s). One thing, I have noticed is that currently
> you need to supply both codec_name (or DT node) _and_ codec_dai_name.
> For that it would be helpful, if ASoC supplies helpers to get the DAI
> by index and use phandle with args here.

This should follow the same pattern as the other board bindings.

> i2s1: audio-controller at b0000 {
> 	compatible = "marvell,dove-i2s";
> 	reg = <0xb0000 0x2345>;
> 	audio-codecs = <&spdif 0>;
> };

No, things are glued together using the machine driver - again, look at
how all the other systems work.  The wiring on the board can get
interesting enough to need a binding of its own, for very simple
bindings that should just be pointing to a generic driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/384d21d3/attachment.sig>
