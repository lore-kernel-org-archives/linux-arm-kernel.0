From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 09 Dec 2011 18:26:44 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code checks
 for kprobes.
In-Reply-To: <1323453935.14174.22.camel@linaro1>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>	
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>	
 <20111209155450.GI5196@mudshark.cambridge.arm.com> <4EE234A8.80208@arm.com>	
 <20111209164029.GL5196@mudshark.cambridge.arm.com>
 <1323453935.14174.22.camel@linaro1>
Message-ID: <4EE252E4.3040701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/11 18:05, Jon Medhurst (Tixy) wrote:
>>> Yes, that is functionally equivalent, and what I did in the RFC version,
>>> but it ended up looking messy at the calling point.
>>
>> Ok, then could you route the ARM variant through the wrapper too?
>
> The function Leif added is for checking the condition code in an ARM
> instruction, so it doesn't need a wrapper when used for this.

It doesn't, but...

> The other locations in the kprobes tests get the condition nibble from
> the ITSATE or from thumb conditional branch instructions. In these cases
> the code looks cleaner if the condition is passed as a value between 0x0
> and 0xf, rather than being shift up to bit position 28 where the
> conditional ARM instructions have it encoded.

I did what Will suggested though, and it does make it a bit cleaner. It 
also moves the ARM_OPCODE_* testing out of the test_context_cpsr code, 
so that all three cases have the probe_should_run setting pretty much 
identical.

I'll post the updated set shortly, so you can have a look.

/
	Leif
