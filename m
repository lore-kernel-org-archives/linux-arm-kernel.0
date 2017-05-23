From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Wed, 24 May 2017 02:24:54 +0530
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <20170523204608.GG24807@lunn.ch>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
Message-ID: <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

I think I forgot to compile it for ARMv5. Let me send the patch again
in few minutes.

I appreciate the help.
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
