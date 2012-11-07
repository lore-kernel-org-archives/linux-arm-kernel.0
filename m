From: Dander.He@sonymobile.com (He, Dander)
Date: Wed, 7 Nov 2012 09:24:49 +0800
Subject: what's the purpose for the few bytes at the end of kernel stack
Message-ID: <4BD5AEA95F49F0438C51470A9A2A7A0C0CF752@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Recently I?m studying linux kernel. I have a question about the space after struct pt_regs in kernel stack.
Why reserved 8 bytes at the end of kernel stack for ARM and 32 bytes for MIPS?

Do you know what?s the purpose for it?  Who and where use it?

I checked the real kernel stack for some processes. Some of them are all zero. Some of them are not.
Here are some sample data on ARM for those 8 bytes in different kernel stack:
0x55555575      0x55155545
0x5d555574      0xf17d5552
0x55155555      0x15155151
0x51555d55      0x55515545
0x5d555574      0x7579d552
0x55795534      0xf1055515
0xa83fc821      0xa83fcc21
0x55795534      0xf1055d15
0x557555dd      0x55659155
0x51555d55      0x55515545
0x5355545d      0x54c45135
0x57555455      0x6f45f545

Br/Dander



1.       In arm, it?s reserved 8 bytes
kernel/arch/arm/include/asm/thread_info.h
#define THREAD_START_SP             (THREAD_SIZE - 8)



2.       In mips, it?s reserved 32 bytes.

kernel/arch/mips/kernel/r4k_switch.S

/*
* Offset to the current process status flags, the first 32 bytes of the
* stack are not used.
*/
#define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/6af4d04a/attachment-0001.html>
