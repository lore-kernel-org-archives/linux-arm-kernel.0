From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Apr 2014 11:53:25 -0600
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140422171141.GW24070@n2100.arm.linux.org.uk>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com>
 <535681A4.1080402@monstr.eu>
 <20140422171141.GW24070@n2100.arm.linux.org.uk>
Message-ID: <20140422175325.GD23955@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 06:11:42PM +0100, Russell King - ARM Linux wrote:

> Put another way, if your platform is part of the multi-platform kernel
> then you are *excluded* from being able to use this... unless you hack
> the Kconfig, and then also provide a constant value for PHYS_OFFSET,
> thereby _tying_ the kernel you built to a _single_ platform.

That is exactly right. To get a fixed LMA you must commit to a
non-relocatable kernel image.

Realistically this patch would need to be accompanied by something
that makes ARM_PATCH_PHYS_VIRT optional for multiplatform based on
EXPERT or similar.

The best usecase seems to be to support ELF tooling for low level
debugging activities, a non-relocatable image isn't a blocker for that
case.

Since the patch is a no-op if LOAD_OFFSET isn't set, is there a
downside I don't see?

Thanks,
Jason
