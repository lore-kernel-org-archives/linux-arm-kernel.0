From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 May 2011 08:15:42 -0700
Subject: [PATCH v5 4/8] arm/dt: probe for platforms via the device tree
In-Reply-To: <20110429071548.12522.56929.stgit@ponder>
References: <20110429070135.12522.35745.stgit@ponder>
	<20110429071548.12522.56929.stgit@ponder>
Message-ID: <20110502151542.GG2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [110429 00:13]:
> +
> +/**
> + * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
> + * @dt_phys: physical address of dt blob
> + *
> + * If a dtb was passed to the kernel in r2, then use it to choose the
> + * correct machine_desc and to setup the system.
> + */
> +struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
> +{
...

> +
> +	/* Retrieve various information from the /chosen node */
> +	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);

Just to make sure we're considering properly what this change means..

Does this patch require using CONFIG_CMDLINE_FORCE for older bootloaders
with the device tree append patch?

Or should we still somehow get ATAG_CMDLINE let's say in the uncompress
code and use that if nothing else is found?

Otherwise booting old boards with the same kernel will be painful as
it requires a kernel recompile to set the cmdline..

Also, not counting the separate DT append issues, I got things booting
with these patches (and the dts files) on omaps. So for patches 1 - 5,
and patch 8:

Tested-by: Tony Lindgren <tony@atomide.com>

I don't have versatile or tegra, so can't test those :)
