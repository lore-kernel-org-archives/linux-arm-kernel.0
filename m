From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 29 Sep 2015 12:05:27 +0100
Subject: [PATCH v3 1/7] acpi: Add early device probing infrastructure
In-Reply-To: <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150929110527.GB17577@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 03:49:12PM +0100, Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
> 
> In order to allow some basic probing based on the ACPI tables,
> introduce "struct acpi_probe_entry" which contains just enough
> data and callbacks to match a table, an optional subtable, and
> call a probe function. A driver can, at build time, register itself
> and expect being called if the right entry exists in the ACPI
> table.
> 
> A acpi_probe_device_table() is provided, taking an identifier for
> a set of acpi_prove_entries, and iterating over the registered
> entries.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/acpi/scan.c               | 39 +++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 10 ++++++
>  include/linux/acpi.h              | 66 +++++++++++++++++++++++++++++++++++++++

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
