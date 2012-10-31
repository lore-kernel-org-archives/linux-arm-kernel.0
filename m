From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 31 Oct 2012 10:05:43 +0100
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
 <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
Message-ID: <1803719.beylA4kOPP@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 31, 2012 04:34:21 AM Jean Pihet wrote:
> Paul,
> 
> - Added Rafael for the PM QoS discussion -
> 
> On Tue, Oct 30, 2012 at 10:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 30 Oct 2012, Paul Walmsley wrote:
> >
> >> Based on a very quick look, I'd say the original patch 3db11fe is broken.
> >> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
> >> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
> >> omap2plus_defconfig.
> >
> > So in fact to follow up on this, looks like one of two changes are needed:
> >
> > 1. Revert 3db11fe
> >
> > or
> >
> > 2. If CONFIG_CPU_IDLE=n, the driver needs to call disable_hlt() in place
> > of the pm_qos constraint add, and call enable_hlt() in place of the pm_qos
> > constraint remove.
> I do not think this is correct. Using disable_hlt is a too radical
> solution and will prevent the idle completely, this is not what we
> want.
> 
> Rafael, what do you think?

Well, I agree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
