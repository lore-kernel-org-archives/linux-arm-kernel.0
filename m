From: smuckle@codeaurora.org (smuckle at codeaurora.org)
Date: Mon, 21 Jun 2010 17:23:38 -0700 (PDT)
Subject: [RFC PATCH] smp: parallel smp boot option
In-Reply-To: <1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
	<20100621220030.GC13624@n2100.arm.linux.org.uk>
	<1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <1267e9ffe4a72e14bb7ede32a2d893f3.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, 2010-06-21 at 23:00 +0100, Russell King - ARM Linux wrote:
>> On Mon, Jun 21, 2010 at 02:40:22PM -0700, Daniel Walker wrote:
>> > +#ifdef CONFIG_SMP_PARALLEL_START
>> > +	bl	__smp_secondary_spin
>> > +#endif
>>
>
> Your OK with this hook? I was thinking it might be better to check if
> it's the book cpu or the secondary here instead of in
> arch/arm/mach-msm .
>
> Steve, do you have any thoughts on that?

If we do keep the hook, I think it'd be better to leave it up to the
platform specific code to do the test, in case for some reason it's not as
simple as reading the MPIDR register. It also keeps the impact to head.S
minimal.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
