From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jan 2014 15:20:49 +0000
Subject: [PATCH v2 0/9] CPU enable method based SMP/hotplug + MSM
 conversion
In-Reply-To: <52CB2BDF.9040208@codeaurora.org>
References: <1387845593-10050-1-git-send-email-sboyd@codeaurora.org>
 <52CB2BDF.9040208@codeaurora.org>
Message-ID: <20140108152049.GD11753@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jan 06, 2014 at 10:19:11PM +0000, Stephen Boyd wrote:
> Ping? Can anyone take a look at the generic ARM and DT binding patches
> and provide acks/reviews? I'd like to send this through arm-soc via the
> MSM tree if possible.

Apologies for the delay. It's taking a while to warm up after christmas.

> 
> On 12/23/13 16:39, Stephen Boyd wrote:
> > This is a rework of patches sent a months back by Rohit[1].
> > The goal of these patches is to add support for SMP and (basic)
> > hotplug on MSM based SoCs. To get there, we add support for a
> > generic way to hook in SMP/hotplug support code based on DT. To
> > show how it's used, we convert the MSM8660 SMP support code over
> > to the new method. After that we add support for the rest of the
> > upstream MSM SoCs (note these patches are piled high on top of
> > Rohit's patches to add 8074 support to MSM[2] and my follow ups[3,4],
> > but this should only matter to the MSM maintainers).
> >
> > This is one of the last items of code that still requires us to have
> > a mach directory and a machine descriptor. We should be able to move
> > the hotplug/smp code out of mach directories if this approach is
> > accepted.

Thanks for doing the rework. This looks really good to me now.

I'd gotten myself confused while reading the bindings, but having now
had a look over the dts files my concerns were invalid.

Hopefully we can move more platforms to use enable-methods now :)

Cheers,
Mark.
