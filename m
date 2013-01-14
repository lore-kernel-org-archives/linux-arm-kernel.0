From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 10:00:30 +0000
Subject: [PATCH 02/11] ARM: nomadik: initial devicetree support
In-Reply-To: <CACRpkdbeeQC0bE7CEkBeHU=M03VBXNLd_20eyzjT39YJB9H-wg@mail.gmail.com>
References: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
 <20130108095729.GA2718@e106331-lin.cambridge.arm.com>
 <20130111170411.320D73E20EC@localhost>
 <20130111175749.GJ19765@e106331-lin.cambridge.arm.com>
 <CACRpkdbeeQC0bE7CEkBeHU=M03VBXNLd_20eyzjT39YJB9H-wg@mail.gmail.com>
Message-ID: <20130114100030.GA7990@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 07:02:06AM +0000, Linus Walleij wrote:
> On Fri, Jan 11, 2013 at 6:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jan 11, 2013 at 05:04:11PM +0000, Grant Likely wrote:
> >> On Tue, 8 Jan 2013 09:57:29 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >
> >> > Maybe I've misunderstood how this is laid out, but I can't see where we get a
> >> > cpus node from in the board's dts. Has this just been forgotten?
> >>
> >> A cpus node isn't required if it doesn't provide any non-discoverable
> >> information.
> >
> > Seeing the discussion around the Tegra #CPUs detection code, I'd think we
> > should have one:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140209.html
> 
> Sorry I cannot figure out how to handle this request.
> 
> The Nomadik has one (1) ARM926EJ-S CPU.

Oh! I hadn't realised the Nomadik was v5. The above will be completely
irrelevant. Sorry for wasting everyone's timer over this.

In way of an explanation, further down the thread [1,2] it becomes a discussion
of /cpus node requirements. The long and short of it is that for v{6,7} there's
no standard way of detecting the number of CPUs, and no way of detecting the
CPU IDs (MPIDR.Aff{2,1,0}), so we should always describe this in dt.

For v5 this is indeed useless.

> Currently there is no other uniprocessor machine in arch/arm/* doing this,
> so have I understood it correctly that you are asking me to do something
> that has never been done before, and that all the existing device tree
> implementations should also do this in the end?

I think all v6+ platforms should have /cpus/cpu at N nodes for consistency across
UP and SMP systems. For v{4,5}, this isn't really necessary, unless people want
to conform to the letter of the law from ePAPR ("A cpus node is required for
all device trees."). I'm not too worried about this.

> The references discussion introduce ARM_CPU_PART_CORTEX_A15
> and ARM_CPU_PART_CORTEX_A9 and these are vastly newer
> systems than the Nomadik, there is no handling of the older CPU types.

Sorry, I should've linked to the more relevant parts of the thread [1,2].

> Are you asking for some new infrastructure to support, mainly for
> the sake of itself (like the nice completeness of the device tre), cpu
> nodes in these device trees?

I was asking for a /cpus/cpu node, but as you've pointed out this is a v5
platform, and as such this isn't needed.

> Does this reasoning also extend to the MIPS, PPC and Sun use of
> device trees as well then, as they don't do that, or do you mean this
> should be done only for the ARM family?
> 
> As you see I don't quite get it, could you elaborate?

Hopefully the above explanation makes sense?

> Yours,
> Linus Walleij

Thanks,
Mark.
