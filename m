From: koro.chen@mediatek.com (Koro Chen)
Date: Tue, 21 Apr 2015 10:27:13 +0800
Subject: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <20150420205511.GL14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
 <1429510944.30743.36.camel@mtksdaap41>
 <20150420205511.GL14892@sirena.org.uk>
Message-ID: <1429583233.14794.40.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-20 at 21:55 +0100, Mark Brown wrote:
> On Mon, Apr 20, 2015 at 02:22:24PM +0800, Koro Chen wrote:
> > On Sat, 2015-04-18 at 18:51 +0100, Mark Brown wrote:
> > > On Fri, Apr 10, 2015 at 04:14:09PM +0800, Koro Chen wrote:
> 
> > > Ah, so the SRAM is directly memory mappable.  Nice.  But we have a
> > > limited amount of it so need to allocate it to a device somehow based on
> > > some factor I guess?
> 
> > Yes, actually SRAM is only used for the main playback path (which is
> > memif "DL1") to achieve low power in real use case. Maybe you think it's
> > better to not describe this in the device tree, but to choose SRAM
> > automatically if memif "DL1" is chosen?
> 
> Since it's directly memory mappable is there actually any cost in
> latency terms from using the SRAM in low latency cases (or did I misread
> what the code was doing there)?  If it can only be used with one
> interface and there's no downside from using it...
The SRAM size to be used is defined by params_buffer_bytes(params), not
fixed (of course limited by the actual available SRAM size on HW), so
the latency should be the same compared to a DRAM having the same size. 

The SRAM can be used by any memif, and that's why the plan was let DT
make the decision.
