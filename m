From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Aug 2012 15:59:06 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <20120823143757.GB7995@opensource.wolfsonmicro.com>
References: <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
 <20120823132618.GB1047@gmail.com>
 <20120823143757.GB7995@opensource.wolfsonmicro.com>
Message-ID: <20120823145904.GC1047@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 03:37:57PM +0100, Mark Brown wrote:
> On Thu, Aug 23, 2012 at 02:26:19PM +0100, Lee Jones wrote:
> 
> > > I think Ola is suggesting probing the DMA driver from the machine which
> > > will also work though I'm not 100% sure if I'm parsing the above
> > > correctly.  The issue in DT terms is that if the DMA controller is
> > > shared with a bunch of other IPs then it should have one node shared
> > > between them all and not a bunch of shim nodes inserted in the middle
> > > which only exists due to the way Linux instantiates stuff.
> 
> > When you say 'machine', do you mean from arch/<arch>/mach-*? If so, I'm
> > keen for that not to happen.
> 
> No, sound/soc/ux500/snowball.c or whatever.  At least that's my guess.

Ah, I see. Maybe the mop500.c file then.

> > > They instantiate the PCM driver dynamically from the DAI when it's
> > > probed which is pretty much what you're patch is doing.
> 
> > So they do it in the same why I have with this patch? Do you know why
> > Ola might think this is a bad idea?
> 
> I'm not 100% sure, I'm guessing it might be down to the fact that you
> end up with multiple PCM drivers.  We could avoid that with refcounting
> but nobody's really worried about it.

I think I'll wait for Ola to get back, as he's the expert on this stuff.

I'll attempt to re-jig the patch-set, as this is a blocker atm.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
