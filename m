From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 14:58:42 +0100
Subject: [PATCH v4] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <1377440747-4564-1-git-send-email-robherring2@gmail.com>
References: <1377440747-4564-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130902135842.GU6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 09:25:47AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The work-around for A15 errata 798181 is not needed if appropriate ECO
> fixes have been applied to r3p2 and earlier core revisions. This can be
> checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
> then the IPI broadcast can be skipped.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

So, this patch in the patch system claims to be against v3.11-rc2:

$ git checkout v3.11-rc2
...
$ pdb gitapply 7804/2
Patching 7804/2...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.15757 2>&1 exited with non-zero status: 256
error: patch failed: arch/arm/include/asm/tlbflush.h:443
error: arch/arm/include/asm/tlbflush.h: patch does not apply
error: patch failed: arch/arm/kernel/smp_tlb.c:70
error: arch/arm/kernel/smp_tlb.c: patch does not apply
error: patch failed: arch/arm/mm/context.c:245
error: arch/arm/mm/context.c: patch does not apply

> v3:
> - Rebase to v3.11-rc5 due to commit 1f49856 (ARM: 7789/1: Do not run
>  dummy_flush_tlb_a15_erratum() on non-Cortex-A15)
> - Move the revision checking out of line and use function ptrs.

Hmm, so -rc5 not -rc2 that you put into the patch system...  Also, the
patch you put into the patch system didn't have Will's ack on it.
