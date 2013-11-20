From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 13:33:15 +0000
Subject: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
In-Reply-To: <20131120133458.3822a165@armhf>
References: <cover.1384862950.git.jsarha@ti.com>
 <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
 <20131120102342.7befe75e@armhf>
 <20131120100959.GV2674@sirena.org.uk>
 <20131120133458.3822a165@armhf>
Message-ID: <20131120133315.GC2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 01:34:58PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > We still want to be able to have users just name the CODEC on their
> > board rather than have to type in all the details from the datasheet,
> > if we're going to try to amalgamate the drivers it should still let
> > people do that.

> OK. But it seems to me that the codec is not tied to the board, but
> rather to the audio connector / transmitter.

No, not at all.  The majority of these devices are simple CODECs, DACs
and ADCs with no register control which are soldered down onto the
board.  What's connected beyond them is irrelevant.  If anything the
devices that don't have fixed functions are even more likely to want or
need to have specific code, for example code could be written to enforce
the results of HDMI capability discovery.

> In the case of the tda998x HDMI transmitter, either i2s or s/pdif may
> be used, thanks to the actual codecs 'hdmi' and 'spdif tx'. But they
> don't work the same way: the 'hdmi' codec handles both playback and
> record, and recording is disabled by program in the sound device,
> while the 'spdif tx' codec is selected by the codec-dai-name
> ("dit-hifi" - it is "dir-hifi" for recording). It would be nice if
> these codecs would have the same behaviour...

Well, send patches refactoring one or the other then...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/14f218c0/attachment.sig>
