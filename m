From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 23 Feb 2018 11:54:19 +0000
Subject: Build failure on arm64 defconfig for linux-next recently
In-Reply-To: <06af01b0-7d95-35e2-3b21-b54f7ed65efc@rock-chips.com>
References: <06af01b0-7d95-35e2-3b21-b54f7ed65efc@rock-chips.com>
Message-ID: <0cd1b5a5-820a-3984-01b5-141770adbbea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 23/02/18 08:03, Shawn Lin wrote:
> Hi folks,
> 
> I failed to build the arm64 kernel for linux-20180222 and I confirm it
> works for linux-20180206. It seems there was some patches for head.S
> got merged. Is it a known issue? Or a fix is coming?

Yes, I broke it, sorry!

There's a fix queued in arm64/fixes/core already (04c4927359b1). Using a 
different toolchain is another option, since the one I'm currently using 
(gcc-linaro-7.2.1-2017.11) builds it just fine, which is how I managed 
to create this mess in the first place ;)

Thanks,
Robin.

> make ARCH=arm64 defconfig
> 
> make 
> CROSS_COMPILE=gcc-linaro-6.3.1-aarch64/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- 
>  ?ARCH=arm64 -j32
> 
> 
> arch/arm64/kernel/head.S: Assembler messages:
> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> arch/arm64/kernel/head.S:677: Error: junk at end of line, first 
> unrecognized character is `L'
> arch/arm64/kernel/head.S:677: Error: unexpected characters following 
> instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
> arch/arm64/kernel/head.S:677: Error: unexpected characters following 
> instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> make[1]: *** [arch/arm64/kernel/head.o] Error 1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
