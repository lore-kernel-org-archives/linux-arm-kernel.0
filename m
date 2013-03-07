From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 11:20:06 +0000
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130307093117.GB14315@opensource.wolfsonmicro.com>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
 <20130307093117.GB14315@opensource.wolfsonmicro.com>
Message-ID: <20130307112006.GD17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 05:31:23PM +0800, Mark Brown wrote:
> On Thu, Mar 07, 2013 at 09:18:04AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 07, 2013 at 10:33:19AM +0800, Mark Brown wrote:
> 
> > > Could you go into more detail here please?  Looking at the code I'm not
> > > seeing any allocations done by the library code at all, the allocations
> > > are all done by the individual platform DMA drivers so I don't see
> > > anything stopping them doing what they need.
> 
> > I don't know what else you require apart from the description above.  Isn't
> > it rather obvious that you can't preallocate the ALSA buffer against the
> > DMA engine device if you can only obtain the DMA engine device in the open
> > function?
> 
> The bit I'm missing is why this is particularly hard to change, it
> doesn't seem like a massive refactoring and there's not many users.

Well, it requires the thing to be reworked along with everyone who uses
it, specifically snd_dmaengine_pcm_open() and snd_dmaengine_pcm_close().

Now, I could use your excuse that you've given me in the past: "I don't
have much of that hardware so I can't test the changes, so I'm not going
to touch this code evar again!"  (That's basically what you said about
the AC'97 struct device stuff.)  You can't have it both ways and always
shovel what you don't like onto other people.

So... I'll just go back to quietly sitting on my SA11x0 ASoC support
and totally ignoring mainline with it because of obstructive
maintainers. :)
