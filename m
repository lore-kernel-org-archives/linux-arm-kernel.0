From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 24 Mar 2016 14:16:16 +0100
Subject: [PATCH v6 0/5] ACPI: parse the SPCR table
In-Reply-To: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAJZ5v0gzjtFzig7nEumr83+J2dGb+OA8GNR2i45ZqznfV_hA-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 1:51 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> Move "earlycon" early_param handling to earlycon.c to parse this option once
>
> Patch "ACPI: add definitions of DBG2 subtypes" is required for the next patch.
> ACPI maintainers said that they had got it for the next release of ACPICA,
> but it has not appeared in linux-next yet.

It will.  Patches containing it have just been posted.

> Parse SPCR table, setup earlycon and add register specified console.
>
> Enable parsing this table on ARM64.  Earlycon should be set up
> as early as possible.  ACPI boot tables are mapped in
> arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch()
> and that's where we parse spcr.  So it has to be opted-in per-arch.
>
> Implement console_match() for pl011.
>
> Based on the work by Leif Lindholm [3]
> Thanks to Peter Hurley for explaining how this should work.
>
> Should be applied to next-20160324.
>
> Tested on QEMU.  SPCR support is included in QEMU's ARM mach-virt
> since 2.4 release.

Honestly, I'm not sure why I'm regarded as the right maintainer to send this to.

The only patch here touching generic ACPI code is [3/5] (the [2/5] is
going in through ACPICA) and the rest is all about ARM64 AFAICS.  Why
don't you send it to the ARM64 maintainers instead?

I'll have some comments on [3/5], I'll send them later today or tomorrow.

Thanks,
Rafael
