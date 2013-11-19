From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Nov 2013 19:33:41 +0000
Subject: [PATCH 08/10] ASoC: ux500_pcm: Differentiate between pdata and
 DT initialisation
In-Reply-To: <20131119184829.GF2674@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
 <20131119184829.GF2674@sirena.org.uk>
Message-ID: <20131119193341.GC19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Mark Brown wrote:

> On Tue, Nov 19, 2013 at 11:07:47AM +0000, Lee Jones wrote:
> 
> > require slightly different flags to inform the core that we 'are'
> > booting with DT.
> 
> Is there some situation when we would want to say we're booting from DT
> when we aren't?  Just wondering about the quotes.

The quotes do 'not' mean anything special. :)

> > +static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
> > +	.pcm_hardware = &ux500_pcm_hw,
> > +	.prealloc_buffer_size = 128 * 1024,
> 
> You shouldn't need to set this explicitly, the generic code should be
> able to pick a number for you - if you do need this number please
> explain why the number was chosen in the comments (or fix the core to
> guess better).  At the minute the core just makes up a number too but at
> least then it's a consistent random number between platforms.
> 
> Can you also get away without the pcm_hardware - the core should also
> have support for discovering this by querying the DMA controller?

Despite the '+'s, I'm not actually adding these parameters, I'm
duplicating the pdata version and removing the stuff I 'know' that's
not required. I don't know what happens when/if these two parameters
are removed. I can add this to my TODO when I rip out platform data
support, which will happen when this stuff lands.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
