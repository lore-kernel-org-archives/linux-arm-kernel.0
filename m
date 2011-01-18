From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Jan 2011 15:11:10 +0000
Subject: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take a
	word-aligned pointer
In-Reply-To: <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101180043140.8580@xanadu.home>
Message-ID: <AANLkTim+0nimacapGBuestYUkC4KuShSQdcHFCFa7O9b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 January 2011 06:00, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
>
>> Add additional instructions to our assembly bitops functions to ensure
>> that they only operate on word-aligned pointers. ?This will be necessary
>> when we switch these operations to use the word-based exclusive
>> operations.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> This breaks the Thumb2 kernel build:
>
> ?AS ? ? ?arch/arm/lib/changebit.o
> arch/arm/lib/changebit.S: Assembler messages:
> arch/arm/lib/changebit.S:16: Error: Thumb does not support negative register indexing -- `strne r1,[r1,-r1]'
>
> I also wonder what happens with a misaligned ldrex/strex... Does the
> alignment trap get invoked?

According to the ARM ARM, unaligned ldrex/strex should generate an
alignment fault on ARMv6 (with SCTLR.U bit set) and ARMv7.

-- 
Catalin
