From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 11 Apr 2011 16:50:48 -0500
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <alpine.LFD.2.00.1104110944290.28032@xanadu.home>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
Message-ID: <BANLkTim6N8OAY6dwdOfrCmLwPe=EuUGrAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, whoever's responsibility it is to fix this, whereever it needs
to be fixed, it needs to be fixed, as it is absolutely nuts that you
cannot run an MX51 and MX53 board off the same kernel.

If nobody knows or agrees, can anyone can identify exactly what needs
to be fixed and where, and how much work this would actually be, so
they or someone else can actually go do it, instead of us just
debating about how experimental it might be?

As far as I see it the only reason it depends on EXPERIMENTAL is
because it breaks at least one subarch, it breaks XIP kernels and it
breaks Thumb2 kernels (this last one is not so much a showstopper for
enabling it by default, unless I am mistaken in my assumption that
Thumb2 kernels still don't work reliably right now anyway?)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



2011/4/11 Nicolas Pitre <nico@fluxnic.net>:
> On Mon, 11 Apr 2011, Uwe Kleine-K?nig wrote:
>
>> On Sun, Apr 10, 2011 at 10:02:03PM -0400, Nicolas Pitre wrote:
>> > On Sun, 10 Apr 2011, Uwe Kleine-K?nig wrote:
>> >
>> > > The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
>> > > compile a single (working) kernel for these.
>> >
>> > Really?
>> >
>> > Have a look at CONFIG_ARM_PATCH_PHYS_VIRT. ?It's in mainline and fully
>> > functional.
>> I'm aware of this config item. But still if it's off there must be a
>> distinction that's provided by this patch.
>
> Sure. ?Instead of a compile time expansion of virt_to_phys() and
> phys_to_virt(), you get a run time patching of the kernel binary
> according to the runtime deduced PHYS_OFFSET. ?See commit logs for "git
> log 6fc31d54..b511d75" for the details.
>
>> Currently you can build a
>> kernel for i.MX51 + i.MX53 but IIRC it works on no machine.
>
> Maybe it should be fixed?
>
>> When considering ARM_PATCH_PHYS_VIRT there are more SoCs that could be
>> built into a single image and so needs a more complicated logic.
>
> The ultimate goal is to structure the code so we can build as many SOCs
> together as possible.
>
>> And I don't want to depend on ARM_PATCH_PHYS_VIRT (yet), e.g. because
>> it's new and still depends on EXPERIMENTAL.
>
> When will it be no experimental anymore if no one starts using it? ?RMK
> talked about making it enabled by default, and that could allow for the
> removal of a bunch of arch/arm/*/include/mach/memory.h files.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
