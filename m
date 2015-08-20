From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Aug 2015 11:13:22 +0100
Subject: [PATCH v2 2/5] ACPI / ARM64: remove usage of
 BAD_MADT_ENTRY/BAD_MADT_GICC_ENTRY
In-Reply-To: <1440022048-6285-3-git-send-email-al.stone@linaro.org>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-3-git-send-email-al.stone@linaro.org>
Message-ID: <20150820101322.GA19328@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Wed, Aug 19, 2015 at 11:07:25PM +0100, Al Stone wrote:
> Now that we have introduced the bad_madt_entry() function, and that
> function is being invoked in acpi_table_parse_madt() for us, there
> is no longer any need to use the BAD_MADT_ENTRY macro, or in the case
> of arm64, the BAD_MADT_GICC_ENTRY, too.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm64/include/asm/acpi.h | 8 --------
>  arch/arm64/kernel/smp.c       | 2 --
>  drivers/irqchip/irq-gic.c     | 6 ------
>  3 files changed, 16 deletions(-)

How are you planning to merge this (and which kernel are you targetting?)
You've got Acks for both arm64 and irqchip, so I guess either of those
trees could take it.

Will
