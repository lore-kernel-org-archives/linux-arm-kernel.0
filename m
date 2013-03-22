From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 11:17:04 +0000
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <20130321152206.GA14768@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net> <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
Message-ID: <20130322111704.GZ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 04:22:06PM +0100, Mark Brown wrote:
> On Thu, Mar 21, 2013 at 04:06:27PM +0100, Lars-Peter Clausen wrote:
> 
> > Hm, I only saw this series today would have been good to be on Cc. I've been
> > working on something very similar. My series goes a bit further though, it
> > implements an (almost generic) dmaengine based PCM driver using the of
> > bindings. So you need almost no platform code. The only things that are
> > platform specific at the moment is the pcm_hardware struct, but I'd like to
> > replace that in the future with something that queries the pcm hardware
> > parameter like max_period from the DMA engine driver. And another bit that is
> > still driver specific is a callback that fills the dma_slave_config struct.
> 
> FWIW it might be worth looking at the one rmk wrote but has never wanted
> to submit for whatever reason.

Err no, stop twisting the facts.  I know nothing is ever your fault.  You
rejected it because it was providing support for non-cyclic supporting
DMA engine drivers.

I've since added support to it for cyclic DMA engines, but I've retained
the non-cyclic support in it because I don't see why I should remove it
when it works for me, especially given the difficulties with getting
anything in sound/soc changed once its been merged.

Plus, as I've already said to you, I no longer develop and test it because
the platform I was using is now doing service as my firewall, and you'll
forgive me for not wanting to take the whole of *.arm.linux.org.uk
offline to mess around with ASoC stuff.  But that's not to say I don't
care about the issue.
