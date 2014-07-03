From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 3 Jul 2014 15:28:26 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140703115924.GY410@sirena.org.uk>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
 <20140703133406.2d3e3a1d@armhf>
 <20140703115924.GY410@sirena.org.uk>
Message-ID: <20140703152826.103c9d6c@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014 12:59:24 +0100
Mark Brown <broonie@kernel.org> wrote:

> > > Your board happens to only be able to present the same input on both I2S
> > > and S/PDIF but that might not apply to other boards, they may be able to
> > > route different signals to each which would present a practical problem.  
> 
> > If there are two different streamss on I2S and S/PDIF, and if the audio
> > subsystem wants to route these streams to the same connector (widget
> > 'hdmi-out'), then, somewhere, there should be a software or a design
> > bug. No?  
> 
> Yes, which is why the driver shouldn't silently ignore the situation.
> 
> > Anyway, the tda998x cannot know if the double route is wanted or not.  
> 
> It doesn't need to know, it just needs to identify something it can't
> support either by providing a way to pick which interface is used or by
> rejecting the second interface.

OK. no problem, I can do that: only the first stream is switched and
the second is rejected.

But, this means that there will be a lot of errors when DPCM will be
used, because, in most cases for the Cubox (kirkwood audio + tda998x),
both ways I2S and S/PDIF will be activated at the same time for a
single stream (you may note that the routes from the second input
cannot be blocked by the CODEC after it received the first input,
because these routes have already been computed).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
