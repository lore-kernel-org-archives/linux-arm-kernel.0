From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Aug 2011 10:43:26 +0100
Subject: [PATCH RFC] ARM: vexpress: Use assembler mnemonic for WFI in
	platform_do_lowpower.
In-Reply-To: <20110819211402.GB12654@gallagher>
References: <1313777004-4716-1-git-send-email-nbowler@elliptictech.com>
	<20110819181514.GA12654@gallagher>
	<20110819192638.GA21043@elliptictech.com>
	<20110819211402.GB12654@gallagher>
Message-ID: <CAHkRjk6Fq+1b_uM+DFACS1QVd7B6_1XhqRw-27i88U1VyvLk+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2011 22:14, Jamie Iles <jamie@jamieiles.com> wrote:
> On Fri, Aug 19, 2011 at 03:26:38PM -0400, Nick Bowler wrote:
>> On 2011-08-19 19:15 +0100, Jamie Iles wrote:
>> > On Fri, Aug 19, 2011 at 02:03:24PM -0400, Nick Bowler wrote:
>> [...]
>> > > - ? ? ? ? /*
>> > > - ? ? ? ? ?* here's the WFI
>> > > - ? ? ? ? ?*/
>> > > - ? ? ? ? asm(".word ? ? ?0xe320f003\n"
>> > > + ? ? ? ? asm("wfi\n"
>> > > ? ? ? ? ? ? ? :
>> > > ? ? ? ? ? ? ? :
>> > > ? ? ? ? ? ? ? : "memory", "cc");
>> >
>> > There's a wfi() macro defined in arch/arm/include/asm/system.h that
>> > could be used here.
>>
>> Indeed, thanks for pointing that out.
>>
>> I'm a little wary, however: the wfi macro does not include the "cc"
>> clobber that this code has currently, and I don't know what the
>> implications of removing it are. ?There appears to be no current
>> users of the wfi macro.
>
> As far as I can tell from the ARM ARM, the instruction shouldn't alter
> the condition flags so the cc clobber shouldn't be necessary.

I also don't see why we need the 'cc' flag in here. Just use the wfi() macro.

-- 
Catalin
