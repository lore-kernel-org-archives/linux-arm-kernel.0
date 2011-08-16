From: wad@chromium.org (Will Drewry)
Date: Tue, 16 Aug 2011 16:44:56 -0500
Subject: [RFC,PATCH] arch/arm: compute and export NR_syscalls
In-Reply-To: <1629809.vjtjo6obCs@wuerfel>
References: <1313529267-4428-1-git-send-email-wad@chromium.org>
	<1629809.vjtjo6obCs@wuerfel>
Message-ID: <CABqD9hYavCxA38GbBhbCmBT+PEQQsvhbF4U7xY8P8ygbFy+=Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 4:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 16 August 2011 16:14:26 Will Drewry wrote:
>>
>> asm-exports.c is added instead of reusing asm-offsets.c to avoid a
>> variety of collisions (VM_EXEC, DMA_*, etc). ?It is possible to use the
>> same calls.S mechanism but add NR_syscalls to asm-offsets.c. ?However,
>> at inclusion time for generated/asm-offsets.h, conflicting defines will
>> need to be #undef'd if !__ASSEMBLY__ since it appears that the purpose
>> of asm-offsets.h is to safely bind C language definitions to assembly
>> and not the reverse.
>>
>> - Is this approach palatable?
>> - Should I resend only when paired with the other ftrace-needed patches?
>
> This seems overly complex, compared to a one-line change adding the symbol
> to asm/unistd.h. The only other architecture that uses an approach
> like the one you have posted is x86-64, and it's simpler there
> because it can easily be done in asm-offsets.c there without the need
> to create another helper.

Agreed!

I proposed this approach based solely on prior threads I've seen. E.g.,
- https://lkml.org/lkml/2007/6/1/427
  (don't just #define)
- https://lkml.org/lkml/2009/8/27/280
  (todo: x86-32 to move to x86-64)

If a single line #define is good enough, then it certainly works for me.

thanks!
will
