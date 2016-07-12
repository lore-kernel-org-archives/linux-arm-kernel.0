From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 12 Jul 2016 12:42:06 +0100
Subject: [PATCH v9 0/7] ACPI / processor_idle: Add ACPI v6.0 LPI support
In-Reply-To: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <5784D78E.7010409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/16 18:07, Sudeep Holla wrote:
> ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
> method to describe processor idle states. It extends the specification
> to allow the expression of idle states like C-states selectable by the
> OSPM when a processor goes idle, but may affect more than one processor,
> and may affect other system components.
>
> LPI extensions leverages the processor container device(again introduced
> in ACPI 6.0) allowing to express which parts of the system are affected
> by a given LPI state. It defines the local power states for each node
> in a hierarchical processor topology. The OSPM can use _LPI object to
> select a local power state for each level of processor hierarchy in the
> system. They used to produce a composite power state request that is
> presented to the platform by the OSPM.
>
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
>

I was hoping to get this in v4.8 now that merge window is
delayed/extended if you have no further comments on this series.

-- 
Regards,
Sudeep
