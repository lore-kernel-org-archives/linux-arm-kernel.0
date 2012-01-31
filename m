From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 31 Jan 2012 08:23:14 +0000
Subject: [PATCHv2 0/6] ARM: jump label support
In-Reply-To: <1327757725-10114-1-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
Message-ID: <1327998194.13821.12.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-01-28 at 19:05 +0530, Rabin Vincent wrote:
> v2:
>  - Use helper macros from Dave Martin's "ARM: Add generic instruction opcode
>    manipulation helpers"
>    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7278/1

This patch is broken, it contains two diff listings for
arch/arm/include/asm/opcodes.h

The second one looks more correct as the diff accounts for commit
0c9030deaf59d444 (ARM: 7206/1: Add generic ARM instruction set condition
code checks). However, when opcodes.h is included in assembler files it
produces error as it #includes C headers.

Moving the #ifndef __ASSEMBLY__ to above the #includes makes things
compile cleanly...

+#ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/swab.h>

-#ifndef __ASSEMBLY__


-- 
Tixy
