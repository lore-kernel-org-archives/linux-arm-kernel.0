From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Aug 2013 10:59:38 +0100
Subject: [PATCH v3] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <1376521638-24369-1-git-send-email-robherring2@gmail.com>
References: <1376521638-24369-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130820095938.GB9402@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:07:18AM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The work-around for A15 errata 798181 is not needed if appropriate ECO
> fixes have been applied to r3p2 and earlier core revisions. This can be
> checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
> then the IPI broadcast can be skipped.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> v3:
> - Rebase to v3.11-rc5 due to commit 1f49856 (ARM: 7789/1: Do not run
>  dummy_flush_tlb_a15_erratum() on non-Cortex-A15)
> - Move the revision checking out of line and use function ptrs. I'm open
>  to suggestions if there is a better place than setup.c for the init.

Maybe arch/arm/kernel/smp_tlb.c, since that's the area affected by this
erratum? No strong opinions though.

Will
