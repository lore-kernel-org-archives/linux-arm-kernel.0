From: ahs3@redhat.com (Al Stone)
Date: Thu, 20 Aug 2015 10:57:05 -0600
Subject: [PATCH v2 2/5] ACPI / ARM64: remove usage of
 BAD_MADT_ENTRY/BAD_MADT_GICC_ENTRY
In-Reply-To: <20150820101322.GA19328@arm.com>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-3-git-send-email-al.stone@linaro.org>
 <20150820101322.GA19328@arm.com>
Message-ID: <55D606E1.4040804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2015 04:13 AM, Will Deacon wrote:
> Hi Al,
> 
> On Wed, Aug 19, 2015 at 11:07:25PM +0100, Al Stone wrote:
>> Now that we have introduced the bad_madt_entry() function, and that
>> function is being invoked in acpi_table_parse_madt() for us, there
>> is no longer any need to use the BAD_MADT_ENTRY macro, or in the case
>> of arm64, the BAD_MADT_GICC_ENTRY, too.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> ---
>>  arch/arm64/include/asm/acpi.h | 8 --------
>>  arch/arm64/kernel/smp.c       | 2 --
>>  drivers/irqchip/irq-gic.c     | 6 ------
>>  3 files changed, 16 deletions(-)
> 
> How are you planning to merge this (and which kernel are you targetting?)
> You've got Acks for both arm64 and irqchip, so I guess either of those
> trees could take it.

Yeah, this is a little messy.  If I can get into 4.2, that would be nice,
but not required -- arm64 already has a usable patch for now, and that's
the only arch affected.  So, 4.3 was my primary target (which is why I
worked with linux-next for these).

Which tree?  Yeesh.  1/5 and 5/5 are ACPI only and required for the rest
to work properly; 2/5 is arm64, 3/5 is ia64, and 4/5 is x86.  ARM folks are
the only ones to have provided acks or reviews, however.  I guess I was
assuming this would have to go in via Rafael's ACPI tree since those are
the key parts -- the arch-specific patches would remove safety checks on
MADT subtables without replacing them, if they went in before the ACPI
patches.

Does that make sense?  What do you think?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
