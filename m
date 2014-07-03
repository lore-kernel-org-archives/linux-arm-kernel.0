From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 3 Jul 2014 07:49:59 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140702194252.GN410@sirena.org.uk>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
Message-ID: <20140703074959.7c489912@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jul 2014 20:42:52 +0100
Mark Brown <broonie@kernel.org> wrote:

> > I tested this CODEC with both DAPM and DPCM. If the audio subsystem
> > asks for streaming on both I2S and S/PDIF, only the last call is served
> > (this depends on the order of the DAI links in the audio card creation
> > table).  
> 
> I'd expect this to return an error for the busy DAI rather than just
> silently ignore it failing to start or (better) implement some control
> to let the user select which of the DAIs is active.

Mark,

This is not an error. If the audio subsystem (DPCM, not the user)
chooses to activate both I2S and S/PDIF, this means the HDMI audio may
be taken either from I2S or from S/PDIF: both inputs have the right
format and rate.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
