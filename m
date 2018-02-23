From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 23 Feb 2018 16:03:34 +0800
Subject: Build failure on arm64 defconfig for linux-next recently
Message-ID: <06af01b0-7d95-35e2-3b21-b54f7ed65efc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I failed to build the arm64 kernel for linux-20180222 and I confirm it
works for linux-20180206. It seems there was some patches for head.S
got merged. Is it a known issue? Or a fix is coming?

make ARCH=arm64 defconfig

make 
CROSS_COMPILE=gcc-linaro-6.3.1-aarch64/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- 
  ARCH=arm64 -j32


arch/arm64/kernel/head.S: Assembler messages:
arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
arch/arm64/kernel/head.S:677: Error: junk at end of line, first 
unrecognized character is `L'
arch/arm64/kernel/head.S:677: Error: unexpected characters following 
instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
arch/arm64/kernel/head.S:677: Error: unexpected characters following 
instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
make[1]: *** [arch/arm64/kernel/head.o] Error 1
