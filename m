From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sun, 25 Feb 2018 11:50:37 +0900
Subject: [BUG] arm64: Build error with gcc 6
Message-ID: <20180225115037.5613c91f061163dcf1d36023@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

commit e1a50de37860 ("arm64: cputype: Silence Sparse warnings")
introduces "UL" suffix to a hex number, but it causes a build error with gcc-6 series.
I've hit below error with 6.2.1 and 6.4.1. Of course this is resolved by the latest
stable gcc-7.2.1. But from the compatibility point of view, should we revert it?

  AS      arch/arm64/kernel/head.o
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S: Assembler messages:
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: junk at end of line, first unrecognized character is `L'
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: unexpected characters following instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
/home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: unexpected characters following instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
make[2]: *** [/home/mhiramat/ksrc/linux/scripts/Makefile.build:425: arch/arm64/kernel/head.o] error 1

I've checked with below 2 latest gccs.

http://releases.linaro.org/components/toolchain/binaries/latest-6/aarch64-linux-gnu/gcc-linaro-6.4.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz

http://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
