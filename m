From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 27 Oct 2014 13:45:48 +0100
Subject: [PATCH 01/10] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <20141027121300.GR8768@arm.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <f57759dbc105dd3996acd959d4e3157224ff81fa.1414099246.git.geoff@infradead.org>
 <20141024092451.GA24265@leverpostej>
 <20141027121300.GR8768@arm.com>
Message-ID: <CAMJs5B-=qhTayazFfw5cHegFuE2_xwR-qN32w6dBdhtKD0wq8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 1:13 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Oct 24, 2014 at 10:24:51AM +0100, Mark Rutland wrote:
>> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
>> > Some of the macros defined in kvm_arm.h are useful in assembly files, but are
>> > not compatible with the assembler.  Change any C language integer constant
>> > definitions using appended U, UL, or ULL to the UL() preprocessor macro.  Also,
>> > add a preprocessor include of the asm/memory.h file which defines the UL()
>> > macro.
>> >
>> > Fixes build errors like these when using kvm_arm.h in assembly
>> > source files:
>> >
>> >   Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'
>> >
>> > Signed-off-by: Geoff Levand <geoff@infradead.org>
>>
>> Thanks for putting this together, Geoff.
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> This doesn't apply against -rc2 (see below). If you send a rebased version
> of this patch, I'm happy to queue it for 3.19.
>
> Alternatively, it could go via the kvm tree. Christoffer, Marc, do you have
> a preference? (the kexec stuff depends on this, so that's why I was thinking
> of queuing it in the arm64 tree).
>
I'm fine with you picking it up.

Thanks,
-Chrsitoffer
