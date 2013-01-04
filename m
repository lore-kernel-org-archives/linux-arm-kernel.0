From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Jan 2013 20:50:04 +0000
Subject: [PATCH v3 0/7] arm64: ARMv8 RTSM model SoC support
In-Reply-To: <50E7005A.7070307@codeaurora.org>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
 <50E7005A.7070307@codeaurora.org>
Message-ID: <CAHkRjk5w+bX+W1An0nkM0JUMR4QVO_ZVHx37vLJ9BDmO9DVxOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 4 January 2013 16:16, Christopher Covington <cov@codeaurora.org> wrote:
> On 01/04/2013 09:17 AM, Catalin Marinas wrote:
>> That's the third version of the patch series adding support for the
>> ARMv8 RTSM model (vexpress-like) to the AArch64 kernel. There is no
>> SoC-specific code under arch/arm64/ as the kernel makes use of the
>> vexpress support already under drivers/ (apart from dts, defconfig and
>> some Kconfig changes).
>>
>> The patches here can be found on this branch:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-experimental
>
> In case you weren't aware:
>
> git checkout catalin/soc-armv8-experimental
> ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- make vexpress_defconfig
> ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- make Image
>
>   CC      drivers/irqchip/gic.o
> drivers/irqchip/gic.c: In function 'gic_init':
> drivers/irqchip/gic.c:399:2: error: 'handle_arch_irq' undeclared (first use in this function)
> drivers/irqchip/gic.c:399:2: note: each undeclared identifier is reported only once for each function it appears in
>
> arm64 builds fine for me. I haven't tried merging Rob Herring's GIC
> stuff. I may just postpone further poking around until those changes
> land.

I am aware of this, I have a temporary patch adding GIC support under
drivers/irqchip/ (I should have named the config option ARM64_GIC to
avoid building it with CONFIG_ARM). But the right approach is Rob's
patches moving the GIC out of arch/arm/, so once they get into -next
I'll drop mine.

-- 
Catalin
