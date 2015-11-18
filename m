From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 18 Nov 2015 11:39:55 -0800
Subject: [PATCH v9 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <yw1xegfnfa0g.fsf@unicorn.mansr.com> (=?utf-8?Q?=22M=C3=A5ns?=
 =?utf-8?Q?_Rullg=C3=A5rd=22's?= message
 of "Wed, 18 Nov 2015 18:16:47 +0000")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C9558.4020100@sigmadesigns.com>
 <7ha8qbyyiz.fsf@deeprootsystems.com>
 <yw1xegfnfa0g.fsf@unicorn.mansr.com>
Message-ID: <7hegfnxfjo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M?ns Rullg?rd <mans@mansr.com> writes:

> Kevin Hilman <khilman@kernel.org> writes:
>
>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>
>>> Add support for Sigma Designs ARM-based Tango4 "Secure Media Processor"
>>> platforms (i.e. smp8734, smp8756, smp8758, smp8759) built around the
>>> Cortex-A9 MPCore r3p0 (all dual-core, except the 8756).
>>>
>>> Support for older MIPS-based platforms can be found elsewhere:
>>> https://github.com/mansr/linux-tangox
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>>  arch/arm/Kconfig              |  2 ++
>>>  arch/arm/Makefile             |  1 +
>>>  arch/arm/mach-tangox/Kconfig  | 12 ++++++++++++
>>>  arch/arm/mach-tangox/Makefile |  2 ++
>>>  arch/arm/mach-tangox/setup.c  | 32 ++++++++++++++++++++++++++++++++
>>>  arch/arm/mach-tangox/smc.S    |  9 +++++++++
>>>  arch/arm/mach-tangox/smc.h    |  5 +++++
>>
>> Potential bike-shed fodder, but, a dumb question: is the family name
>> actually "tangox" or is the "x" for the number (tango3, tango4, etc.)
>>
>> Assuming it's the later based on usage throughout the patch, I think
>> it'd be better to just use "tango" throughout instead of tangox.
>
> The x indeed stands for a number.  I have no idea what tango1 was or if
> it ever existed.  Tango2 (SMP863x) and tango3 (SMP86[457]x) were MIPS
> based.  Tango4 is ARM based (mostly, the SMP8910 is MIPS) but otherwise
> very similar to tango3.

Thanks for the clarification.

> Since we don't know what tango5 will look like,
> mach-tango4 might be more suitable here.  If tango5 turns out to be
> sufficiently similar, there's no harm from adding support for that to
> the mach-tango4 code (just look at mach-omap2).

Well, mach-omap2 leads to enough confusion that I don't think we need to
use that as a model. ;)  IMO, mach-tango is a better starting point.

> Most of the drivers support both tango3 and tango4, but apparently some
> changes are planned for tango5.

Thanks for the clarification,

Kevin
