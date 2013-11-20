From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 20 Nov 2013 13:34:58 +0100
Subject: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
In-Reply-To: <20131120100959.GV2674@sirena.org.uk>
References: <cover.1384862950.git.jsarha@ti.com>
 <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
 <20131120102342.7befe75e@armhf>
 <20131120100959.GV2674@sirena.org.uk>
Message-ID: <20131120133458.3822a165@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Nov 2013 10:09:59 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 20, 2013 at 10:23:42AM +0100, Jean-Francois Moine wrote:
> 
> > But now, I am wondering again about these `empty`codecs:
> > - in a DT context, should we continue to add / modify such codecs?
> > - what do you think about my generic DT codec? (indeed, I would do a new
> >   version according to the previous remarks)
> 
> We still want to be able to have users just name the CODEC on their
> board rather than have to type in all the details from the datasheet,
> if we're going to try to amalgamate the drivers it should still let
> people do that.

OK. But it seems to me that the codec is not tied to the board, but
rather to the audio connector / transmitter.

In the case of the tda998x HDMI transmitter, either i2s or s/pdif may
be used, thanks to the actual codecs 'hdmi' and 'spdif tx'. But they
don't work the same way: the 'hdmi' codec handles both playback and
record, and recording is disabled by program in the sound device,
while the 'spdif tx' codec is selected by the codec-dai-name
("dit-hifi" - it is "dir-hifi" for recording). It would be nice if
these codecs would have the same behaviour...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
