From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Sep 2012 21:43:25 +0100
Subject: [alsa-devel] [RFC 1/3] ASoC: dmaengine: Don't use runtime
 private data for dmaengine data
In-Reply-To: <5045124D.3050604@metafoo.de>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
 <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk> <5045124D.3050604@metafoo.de>
Message-ID: <20120903204325.GA728@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 10:25:49PM +0200, Lars-Peter Clausen wrote:
> On 09/03/2012 06:59 PM, Liam Girdwood wrote:
> > Use a dedicated member to store dmaengine data so that drivers can
> > use private data for their own purposes.
> > 
> 
> The idea was that we'll eventually get to a point where we won't need private
> data for the drivers using the generic dmaengine code. But for the transitional
> period there is snd_dmaengine_pcm_{set,get}_data which allows to attach driver
> private data to the dmaengine pcm. For an example see how the other users of
> dmaengine pcm handle this.

That's fine if you are writing new drivers from scatch, or know the
driver you're converting inside-out.  Neither applies here (I've
struggled to do anything with the OMAP audio stuff for many many
reasons.)

I rather wish that people who did know the OMAP ASoC driver had stepped
up to this conversion, but alas they haven't.

In any case, if you want people to use the this soc-dmaengine helper
then you have to make the conversion to it simple, and requiring
everyone to totally restructure their drivers to use it does not make
that process simple.

What you have here is the result of several transformations to the
driver, which would _not_ have been possible without this first patch
from Liam.
