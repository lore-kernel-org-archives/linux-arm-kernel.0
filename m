From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Jul 2014 12:59:24 +0100
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140703133406.2d3e3a1d@armhf>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
 <20140703133406.2d3e3a1d@armhf>
Message-ID: <20140703115924.GY410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 01:34:06PM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Your board happens to only be able to present the same input on both I2S
> > and S/PDIF but that might not apply to other boards, they may be able to
> > route different signals to each which would present a practical problem.

> If there are two different streamss on I2S and S/PDIF, and if the audio
> subsystem wants to route these streams to the same connector (widget
> 'hdmi-out'), then, somewhere, there should be a software or a design
> bug. No?

Yes, which is why the driver shouldn't silently ignore the situation.

> Anyway, the tda998x cannot know if the double route is wanted or not.

It doesn't need to know, it just needs to identify something it can't
support either by providing a way to pick which interface is used or by
rejecting the second interface.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/d5383422/attachment.sig>
