From: will.deacon@arm.com (Will Deacon)
Date: Tue, 01 Mar 2011 10:30:39 +0000
Subject: [PATCH 1/4] msm: scm: Mark inline asm as volatile
In-Reply-To: <8yalj112x98.fsf@huya.qualcomm.com>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-2-git-send-email-sboyd@codeaurora.org>
	<1298635017.958.0.camel@e102144-lin.cambridge.arm.com>
	<8yapqqe3bs3.fsf@huya.qualcomm.com> <1298805034.4626.4.camel@jazzbox>
	<8yalj112x98.fsf@huya.qualcomm.com>
Message-ID: <1298975439.7828.2.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Sun, 2011-02-27 at 17:38 +0000, David Brown wrote:
> Per the gcc manual:
> 
>     If your assembler instructions access memory in an unpredictable
>    fashion, add `memory' to the list of clobbered registers.  This will
>    cause GCC to not keep memory values cached in registers across the
>    assembler instruction and not optimize stores or loads to that
>    memory.  You will also want to add the `volatile' keyword if the
>    memory affected is not listed in the inputs or outputs of the `asm',
>    as the `memory' clobber does not count as a side-effect of the `asm'.
>    If you know how large the accessed memory is, you can add it as input
>    or output but if this is not known, you should add `memory'.  As an
>    example, if you access ten bytes of a string, you can use a memory
>    input like:
> 
Right, so if you neglected to check the output from the smc block then
it would be a candidate for removal even with a memory clobber. Now I
see why you want a volatile in there!

For what it's worth:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
