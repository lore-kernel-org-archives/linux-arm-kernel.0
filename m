From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 14:09:06 +0100
Subject: FW: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe
 rather than as a device
In-Reply-To: <20120827163337.GC4339@opensource.wolfsonmicro.com>
References: <014401cd8165$99960c40$ccc224c0$@se>
 <50377C0D.2060905@stericsson.com>
 <20120827163337.GC4339@opensource.wolfsonmicro.com>
Message-ID: <20120914130904.GB12893@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 09:33:38AM -0700, Mark Brown wrote:
> On Fri, Aug 24, 2012 at 03:05:17PM +0200, Ola Lilja wrote:
> 
> > I haven't followed everything in this discussion, but what I meant in an earlier
> > mail was that using the device for platform-DAI (MSP_I2S) also
> > as platform int the DAI-link struct is not anything I can see fit (as in the
> > patch Lee first submitted).
> 
> I'm not sure I fully understand the above - I didn't notice anything
> with the dai links but I have to say that I could've looked more closely
> as I was waiting for ARM side reviews.
> 
> > I can see a few acceptable solutions:
> > 1) Use it as it is! (A virtual device for PCM is created in arch/arm and the
> > probe is invoked from the machine-driver).
> > 2) Since the actual platform is the DMA-block, maybe there is some way of making
> > the device "non-virtual" by having some sub-device in the DMA-driver that is
> > instead triggered in the same way as in 1).
> 
> The option we're using is essentially your option 2 but doing it from
> the DAI driver rather than from the DMA driver (keeping things in the
> audio subsystem since it's an audio specific issue).

Ola could you please reply to this. Without your Ack this is our biggest
blocker. There are other audio drivers which do it this way already. We
are already doing something you suggested, just in a slightly different
(more contained) way.

Please respond.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
