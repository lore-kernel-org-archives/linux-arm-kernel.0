From: yad.naveen@gmail.com (naveen yadav)
Date: Mon, 20 Sep 2010 10:41:20 +0530
Subject: Issue in using mmap on ARM target
In-Reply-To: <AANLkTi=VS34cbaH9TNA9aZ7mVavoTaAiAwMfuRXSxbd8@mail.gmail.com>
References: <AANLkTi=VS34cbaH9TNA9aZ7mVavoTaAiAwMfuRXSxbd8@mail.gmail.com>
Message-ID: <AANLkTi=JXei9uPHR-yn3OUnamV5eu+CbQ+ebaS27=dut@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am facing one issue when executing below progmra on ARM target. The
same program work well on X86 host machine,

When execute on Host(x86). the result are as expected.
[root at localhost naveen]# ./a.out ?0000 b 2
/dev/mem opened.
Memory mapped at address 0xb7f00000.
Value at address 0x0 (0xb7f00000): 0x24
Written 0x2; readback 0x2

But when execute on Target(ARM):
# ./a.out 0 w 20
/dev/mem opened.
Memory mapped at address 0x40003000.
Value at address 0x0 (0x40003000): 0xEA000006
Written 0x14; readback 0xEA000006
#
The value does not change. any idea ....


Kind regards
-------------- next part --------------
A non-text attachment was scrubbed...
Name: devmem2.c
Type: application/octet-stream
Size: 3550 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100920/56f2707f/attachment-0001.obj>
