From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 21:32:44 +0200
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <20130619192211.GH1403@sirena.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <3697657.tZFV7pR81Q@flatron> <20130619192211.GH1403@sirena.org.uk>
Message-ID: <5443580.A5iCQBtp1T@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 of June 2013 20:22:11 Mark Brown wrote:
> On Wed, Jun 19, 2013 at 08:26:12PM +0200, Tomasz Figa wrote:
> > On Wednesday 19 of June 2013 18:40:47 Mark Brown wrote:
> > > -		ret = pd->get_signal(plchan->cd);
> > > +		ret = (pd->get_signal)(plchan->cd);
> > 
> > Hmm, that's strange. The former is a completely valid piece of code...
> 
> I know, hence...
> 
> > > to get it to build which makes me suspect the compiler a bit as
> > > well...
> 
> ...my comment about suspecting the compiler.
> 
> > > I was applying this to -next, are there any other dependencies I
> > > need or anything?
> > 
> > Hmm, I've been testing this on top of my common clock framework and
> > device tree patches, but I don't think this had any effect. Did you
> > add necessary clkdev lookups to the clock driver?
> 
> No, I didn't - that's most likely it, I didn't really investigate.  I
> didn't test the watchdog stuff as the clocks didn't get sent to me.

I always try to keep you on Cc of my patches for s3c64xx, as you are the 
most active user of this platform (if not the only one other than me) and 
this was the case for clock patches as well, just checked that.

Seems like I forgot to add you to watchdog patches, sorry. But you didn't 
miss anything, since they were rather trivial ones.

> > In Samsung CCF alias notation it looks like this:
> > 
> > +       ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
> > +       ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),
> > 
> > Not sure how hard it will be to add such lookups to the old clock
> > driver, though.
> 
> It's pretty much the same providing you know which clock needs to be
> used.
> 
> > I will test this applied directly on top of current linux-next when I
> > find some time, but for now you might check out my v3.11-devel branch
> > on my github:
> > 
> > https://github.com/tom3q/linux.git
> 
> Will try to get round to it.

OK.

Best regards,
Tomasz
