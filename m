From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Wed, 24 May 2017 02:47:52 +0530
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <20170523204608.GG24807@lunn.ch>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
Message-ID: <CAHgaXdK-bpPxMfi=J3v2hfrdqFaEGvibi09K4SVoPabe3T2u5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

I am attaching the additional patch to make it work for ARMv5 as well.
Let me know if you find any issues with this.

Please apply 0002-Editted-for-ARMv5-compilation.patch after applying
the first patch.
Best,
Shubham Bansal


On Wed, May 24, 2017 at 2:16 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, May 24, 2017 at 12:03:53AM +0530, Shubham Bansal wrote:
>> The JIT compiler emits ARM 32 bit instructions. Currently, It supports
>> eBPF only. Classic BPF is supported because of the conversion by BPF
>> core.
>
> make mvebu_v5_defconfig
>
> make -s -j 16
> arch/arm/net/bpf_jit_32.c: In function emit_rev16:
> arch/arm/net/bpf_jit_32.c:1019:7: error: implicit declaration of function ARM_MOV_S [-Werror=implicit-function-declaration]
>   emit(ARM_MOV_S(tmp2[0], rn, SRTYPE_LSR, 8), ctx);
>        ^~~~~~~~~
> arch/arm/net/bpf_jit_32.c: In function emit_rev32:
> arch/arm/net/bpf_jit_32.c:1037:36: error: macro "ARM_MOV_I" passed 3 arguments, but takes just 2
>   emit(ARM_MOV_I(tmp2[1], rn, 0xff00), ctx);
>                                     ^
> arch/arm/net/bpf_jit_32.c:1037:7: error: ARM_MOV_I undeclared (first use in this function)
>   emit(ARM_MOV_I(tmp2[1], rn, 0xff00), ctx);
>        ^~~~~~~~~
> arch/arm/net/bpf_jit_32.c:1037:7: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/net/bpf_jit_32.c:1039:41: error: macro "ARM_MOV_I" passed 3 arguments, but takes just 2
>   emit(ARM_MOV_I(tmp2[0], tmp2[0], 0xff00), ctx);
>                                          ^
> arch/arm/net/bpf_jit_32.c: In function build_insn:
> arch/arm/net/bpf_jit_32.c:1393:30: error: macro "ARM_AND_R" requires 3 arguments, but only 2 given
>     emit(ARM_AND_R(rt, tmp2[1]), ctx);
>                               ^
> arch/arm/net/bpf_jit_32.c:1393:9: error: ARM_AND_R undeclared (first use in this function)
>     emit(ARM_AND_R(rt, tmp2[1]), ctx);
>
>     Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-Editted-for-ARMv5-compilation.patch
Type: application/octet-stream
Size: 2045 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/646238cf/attachment.obj>
