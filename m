From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Wed, 4 Sep 2013 02:02:42 +0000
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130903113151.GE15824@intel.com>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130902045050.GE7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520D0D4@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130902063721.GK7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520F101@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130902111200.GP7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E852102A1@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130903113151.GE15824@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E852123D5@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, September 03, 2013 7:32 PM
> To: Lu Jingchang-B35083
> Cc: shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
> 
> On Tue, Sep 03, 2013 at 05:43:21AM +0000, Lu Jingchang-B35083 wrote:
> >   Do you mean the DMA_SLAVE_CONFIG device_control? Yeah, the slave
> driver could pass
> > the slave_id. But the DMA_SLAVE_CONFIG may be called more than once,
> and the eDMA
> > driver just needs to set the slave id once for any given channel, after
> that the
> > transfer is transparent to the device.
> It depends, for a channel requested, if you are only tranferring to a
> particular
> slave device then it can be confugured once.
> so
> 1. allocate channel
> 2. dmaengine_slave_config()
> 
> then you cnan do preare etc multiple times based on need.
Yeah, I think we should just configure the slave id once and this would make the
configuration simply. But by debugging, I find the dmaengine_slave_config() may be
called more one times after requested by on user. So I put the slave id configuration
in the channel request phase. And the effect is the same for exclusive channel.
Thanks!


Best Regards,
Jingchang
