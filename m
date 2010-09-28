From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Sep 2010 20:13:15 +0100
Subject: Issue in using mmap on ARM target
In-Reply-To: <AANLkTi=JXei9uPHR-yn3OUnamV5eu+CbQ+ebaS27=dut@mail.gmail.com>
References: <AANLkTi=VS34cbaH9TNA9aZ7mVavoTaAiAwMfuRXSxbd8@mail.gmail.com>
	<AANLkTi=JXei9uPHR-yn3OUnamV5eu+CbQ+ebaS27=dut@mail.gmail.com>
Message-ID: <20100928191315.GB8649@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 10:41:20AM +0530, naveen yadav wrote:
> Hi all,
> 
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

You are probably trying to write to some read-only memory.

On ARM systems, the boot loader is probably at location zero, and being
stored in flash or mask ROM, will probably not be (immediately) writable.

On x86, location zero tends to be RAM, and so can be written.
