From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 3 Jul 2014 13:34:06 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140703104432.GV410@sirena.org.uk>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
Message-ID: <20140703133406.2d3e3a1d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014 11:44:32 +0100
Mark Brown <broonie@kernel.org> wrote:

> > > I'd expect this to return an error for the busy DAI rather than just
> > > silently ignore it failing to start or (better) implement some control
> > > to let the user select which of the DAIs is active.  
> 
> > This is not an error. If the audio subsystem (DPCM, not the user)
> > chooses to activate both I2S and S/PDIF, this means the HDMI audio may
> > be taken either from I2S or from S/PDIF: both inputs have the right
> > format and rate.  
> 
> Your board happens to only be able to present the same input on both I2S
> and S/PDIF but that might not apply to other boards, they may be able to
> route different signals to each which would present a practical problem.

If there are two different streamss on I2S and S/PDIF, and if the audio
subsystem wants to route these streams to the same connector (widget
'hdmi-out'), then, somewhere, there should be a software or a design
bug. No?

Anyway, the tda998x cannot know if the double route is wanted or not.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
