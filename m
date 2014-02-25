From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Feb 2014 17:02:00 -0800
Subject: [PATCH RESEND v3] clk: return probe defer when DT clock not yet
 ready
In-Reply-To: <20140219185315.GV21483@n2100.arm.linux.org.uk>
References: <20140208132446.2A26694003E@smtp1-g21.free.fr>
 <20140219190305.788e537d@armhf>
 <20140219185315.GV21483@n2100.arm.linux.org.uk>
Message-ID: <20140225010200.22529.17490@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2014-02-19 10:53:15)
> On Wed, Feb 19, 2014 at 07:03:05PM +0100, Jean-Francois Moine wrote:
> > On Mon, 25 Nov 2013 19:47:04 +0100
> > Jean-Francois Moine <moinejf@free.fr> wrote:
> > 
> > > At probe time, a clock device may not be ready when some other device
> > > wants to use it.
> > > 
> > > This patch lets the functions clk_get/devm_clk_get return a probe defer
> > > when the clock is defined in the DT but not yet available.
> > 
> > Hi Mike,
> > 
> > Any news about this patch?
> 
> Mike,
> 
> Can you please have a look at this patch so that either you or I can take
> this.  It /is/ required so that subsystems can correctly identify whether
> a clock is missing because it's not specified in DT, or whether the clock
> is missing because it's specified in DT but doesn't yet exist.
> 
> This patch has been hanging around for ages and deserves some attention.

I only saw this patch now thanks to another thread. I have some
aggressive mail filtering going on and I guess maybe the original ASoC
subject had something to do with that?

Oh well. I've pull this patch into clk-next for testing. I'll see if
anything goes boom.

Thanks for the patch and longsuffering patience!

Regards,
Mike

> 
> Thanks.
> 
