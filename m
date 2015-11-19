From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 19 Nov 2015 11:32:34 -0800
Subject: [PATCH v9 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <564E05E2.3060004@sigmadesigns.com> (Marc Gonzalez's message of
 "Thu, 19 Nov 2015 18:24:50 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C9558.4020100@sigmadesigns.com>
 <7ha8qbyyiz.fsf@deeprootsystems.com>
 <564E05E2.3060004@sigmadesigns.com>
Message-ID: <7hegflvl7x.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> Kevin Hilman wrote:
>
>> Marc Gonzalez wrote:
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
> I should just change tangox to tango everywhere?

IMO, yes.

> This port supports tango4. I will submit a tango5 port in 2016.
> Does that change anything?

Probably not.  I'm assuming it's an SoC in the same family, so the goal
should be to support both from the same mach dir.  Most of the "real"
support should end up in drivers/* and DT descriptions, so the mach
directory should stay very small.

>> Also a MAINTAINERS file entry is appropriate for this new platform
>> support (as scripts/checkpatch.pl should have told you.)
>
> Thanks for pointing that out. I'll send a v10.
> Are these the only issues in your opinion?

I have a couple comments, I'll reply separately.

Kevin
