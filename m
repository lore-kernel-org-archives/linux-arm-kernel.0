From: andrew.murray@arm.com (Andrew Murray)
Date: Tue, 16 Apr 2013 11:30:06 +0100
Subject: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
Message-ID: <20130416103005.GB12726@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> property of a PCI host device, is found in both Microblaze and PowerPC
> architectures. These implementations are nearly identical. This patch
> moves this common code to a common place.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/pci-bridge.h |    5 +-
>  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
>  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
>  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------

Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?

I've tested that it builds on powerpc with a variety of configs (some which
include fsl_pci.c implementation). Though I don't have hardware to verify that
it works.

I haven't tested this builds or runs on MIPS.

You shouldn't see any difference in behaviour or new warnings and PCI devices
should continue to operate as before.

Andrew Murray
