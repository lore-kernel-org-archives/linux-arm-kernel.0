From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 27 Jun 2014 12:01:12 -0500
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140627094648.GE32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal> <20140627085705.GC32514@n2100.arm.linux.org.uk>
 <CAKv+Gu9NfGT8r8FSYzsuP70r1BRD_pdJw7AZHkc4qLt2_SwanA@mail.gmail.com>
 <20140627094648.GE32514@n2100.arm.linux.org.uk>
Message-ID: <53ADA358.7000305@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 04:46 AM, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 11:41:46AM +0200, Ard Biesheuvel wrote:
>> It appears that the EF_ARM_ABI_FLOAT_[SOFT|HARD] defines are just renames of
>>
>> #define EF_ARM_SOFT_FLOAT       0x200
>> #define EF_ARM_VFP_FLOAT        0x400
>>
>> so perhaps use those instead?
> 
> Or maybe provide our own definitions so we're not reliant on the host
> environment providing the correct definitions for these.

Right.

> 
>>> This is what really concerns me about the VDSO.  It adds an additional
>>> dependence on the C library in order to build the kernel.  What if you
>>> don't have a C library in your cross-build setup (I don't.)
>>>
>>
>> This is a host tool, so this is about the host libc not the target libc.
> 
> It still sounds pretty fragile.

Since removing -lgcc from the link (one of the changes from v6 to v7), I
believe the VDSO is not asking more of the toolchain or build
environment than the rest of the kernel does.  I have definitely built
it without a target libc.  Apart from the host program's use of
too-recent ELF constants (now fixed), I would appreciate help
identifying any remaining sources of fragility.
