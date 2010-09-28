From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Tue, 28 Sep 2010 15:08:56 +0200
Subject: Issue in using mmap on ARM target
In-Reply-To: <AANLkTi=JXei9uPHR-yn3OUnamV5eu+CbQ+ebaS27=dut@mail.gmail.com>
References: <AANLkTi=VS34cbaH9TNA9aZ7mVavoTaAiAwMfuRXSxbd8@mail.gmail.com>
	<AANLkTi=JXei9uPHR-yn3OUnamV5eu+CbQ+ebaS27=dut@mail.gmail.com>
Message-ID: <19617.59624.559668.889841@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I am facing one issue when executing below progmra on ARM target. The
> same program work well on X86 host machine,
> 
> When execute on Host(x86). the result are as expected.
> [root at localhost naveen]# ./a.out ?0000 b 2
> /dev/mem opened.
> Memory mapped at address 0xb7f00000.
> Value at address 0x0 (0xb7f00000): 0x24
> Written 0x2; readback 0x2
> 
> But when execute on Target(ARM):
> # ./a.out 0 w 20
> /dev/mem opened.
> Memory mapped at address 0x40003000.
> Value at address 0x0 (0x40003000): 0xEA000006
> Written 0x14; readback 0xEA000006
> #
> The value does not change. any idea ....
> 
There is no RAM at (physical) address 0.
You should check the PHYS_OFFSET setting of your machine to find out
where your RAM is located.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
