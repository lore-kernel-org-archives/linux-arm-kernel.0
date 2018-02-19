From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Feb 2018 12:13:14 +0000
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <20180219111907.GB30394@arm.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
 <36bd758c-dd49-edef-cc1a-20f5b43f5011@huawei.com>
 <20180219110238.GA30394@arm.com>
 <c868d4aa-99f8-6e14-9b26-a4f0ad768f71@huawei.com>
 <20180219111907.GB30394@arm.com>
Message-ID: <20180219121313.lltye3g464zzt7z3@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 11:19:07AM +0000, Will Deacon wrote:
> > >>On 19/02/2018 06:39, Bhupesh Sharma wrote:
> > >>>Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> > >>>Silence Sparse warnings), compilation of arm64 architecture is broken
> > >>>with the following error messages:
> > >>>
> > >>> AR      arch/arm64/kernel/built-in.o
> > >>> arch/arm64/kernel/head.S: Assembler messages:
> > >>> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >>> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >>> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >>> arch/arm64/kernel/head.S:677: Error: junk at end of line, first
> > >>> unrecognized character is `L'
> > >>> arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >>> instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
> > >>> arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >>> instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> > >>>
> > >>>This patch fixes the same by using the UL() macro correctly for
> > >>>assigning the MPIDR_HWID_BITMASK macro value.
> > >>>
> > >>>Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
[...]
> Thanks for the clarification; Catalin -- can you pick this up for -rc3 please?

Done. Strange that it builds fine with newer toolchains.

-- 
Catalin
