From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Jan 2011 17:31:40 -0800
Subject: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
	break because of clktrctrl_mask
In-Reply-To: <alpine.DEB.2.00.1101101214430.5731@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 10 Jan 2011 12:16:28 -0700 (MST)")
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwt7z1p3.fsf@ti.com>
	<alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com>
	<87ipy1vqdi.fsf@ti.com>
	<3f76fc53e9b50d75480bcfe1d2b6312e@mail.gmail.com>
	<874o9ko25j.fsf@ti.com>
	<alpine.DEB.2.00.1101101214430.5731@utopia.booyaka.com>
Message-ID: <87wrmcfcoz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Fri, 7 Jan 2011, Kevin Hilman wrote:
>
>> Rajendra Nayak <rnayak@ti.com> writes:
>> 
>> [...]
>> 
>> > Just another trivial fix.
>> >
>> > From bb46b74d2b0ab3d35e72b760da7e123a891e6813 Mon Sep 17 00:00:00 2001
>> > From: Rajendra Nayak <rnayak@ti.com>
>> > Date: Fri, 7 Jan 2011 14:07:25 +0530
>> > Subject: [PATCH] OMAP: powerdomain: remove unused func declaration
>> >
>> > Trivial fix to remove the unused function declaration
>> > from the powerdomain header.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/powerdomain.h |    1 -
>> >  1 files changed, 0 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/powerdomain.h
>> > b/arch/arm/mach-omap2/powerdomain.h
>> > index c66431e..0b7a357 100644
>> > --- a/arch/arm/mach-omap2/powerdomain.h
>> > +++ b/arch/arm/mach-omap2/powerdomain.h
>> > @@ -165,7 +165,6 @@ struct pwrdm_ops {
>> >  	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
>> >  };
>> >
>> > -void pwrdm_fw_init(void);
>> >  void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops
>> > *custom_funcs);
>> 
>> Note this is line-wrapped. 
>> 
>> Looks like you need to get get-send-email setup so you can avoid having
>> the patch sending problems.
>> 
>> >
>> >  struct powerdomain *pwrdm_lookup(const char *name);
>> 
>> In any case, with Paul's ack, I can queue this with the others.
>
> Normally I would wait for the .39 merge window with something like this, 
> but you're welcome to queue it for the -rc fixes if you feel it's 
> appropriate:

Yeah, I agree.  I'll let you queue this one for .39 as it's not really a
fix.

Kevin
