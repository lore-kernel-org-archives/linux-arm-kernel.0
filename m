From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 04 Jan 2013 11:16:26 -0500
Subject: [PATCH v3 0/7] arm64: ARMv8 RTSM model SoC support
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <50E7005A.7070307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 01/04/2013 09:17 AM, Catalin Marinas wrote:
> Hi,
> 
> That's the third version of the patch series adding support for the
> ARMv8 RTSM model (vexpress-like) to the AArch64 kernel. There is no
> SoC-specific code under arch/arm64/ as the kernel makes use of the
> vexpress support already under drivers/ (apart from dts, defconfig and
> some Kconfig changes).
> 
> The patches here can be found on this branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-experimental

In case you weren't aware:

git checkout catalin/soc-armv8-experimental
ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- make vexpress_defconfig
ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- make Image

  CC      drivers/irqchip/gic.o
drivers/irqchip/gic.c: In function 'gic_init':
drivers/irqchip/gic.c:399:2: error: 'handle_arch_irq' undeclared (first use in this function)
drivers/irqchip/gic.c:399:2: note: each undeclared identifier is reported only once for each function it appears in

arm64 builds fine for me. I haven't tried merging Rob Herring's GIC
stuff. I may just postpone further poking around until those changes
land.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by the Linux Foundation
