From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Feb 2018 11:58:50 +0100
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
Message-ID: <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 7:39 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> Silence Sparse warnings), compilation of arm64 architecture is broken
> with the following error messages:
>
>   AR      arch/arm64/kernel/built-in.o
>   arch/arm64/kernel/head.S: Assembler messages:
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>   unrecognized character is `L'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
>
> This patch fixes the same by using the UL() macro correctly for
> assigning the MPIDR_HWID_BITMASK macro value.
>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Saw the same thing in the kernelci report for linux-next.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that when referencing a commit, it's best to abbreviate the commit
ID to the first 12 characters like "e1a50de37860". You can also a line like

Fixes: e1a50de37860 ("arm64: cputype: Silence Sparse warnings")

which is the standard format to describe such regressions.

       Arnd
