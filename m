From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 1 Jun 2017 16:51:05 +0000
Subject: [PATCH v2] efi: arm: enable DMI/SMBIOS
In-Reply-To: <20170601163614.GC22219@n2100.armlinux.org.uk>
References: <20170601104554.21267-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu-OK=0HSG5KmsZ+Zs0Xu2ox5Cva+Nbtgz0DXigk3e3aiA@mail.gmail.com>
 <20170601163614.GC22219@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu9czLm=i852=GAnx=pmGDDNahTTVpVxWzAfNgzmOWdsaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2017 at 16:36, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> On Thu, Jun 01, 2017 at 10:52:13AM +0000, Ard Biesheuvel wrote:
>> (add Russell to To: field)
>
> Thanks.
>
>> On 1 June 2017 at 10:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > Wire up the existing support for SMBIOS tables (aka DMI), by moving the
>> > arm64 init code to drivers/firmware/efi/arm-runtime.c (which is shared
>> > between ARM and arm64), and adding a asm/dmi.h header to ARM that defines
>> > the mapping routines for the firmware tables.
>> >
>> > This allows userspace to access these tables to discover system information
>> > exposed by the firmware. It also sets the hardware name used in crash
>> > dumps, e.g.,
>> >
>> >   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> >   pgd = ed3c0000
>> >   [00000000] *pgd=bf1f3835
>> >   Internal error: Oops: 817 [#1] SMP THUMB2
>> >   Modules linked in:
>> >   CPU: 0 PID: 759 Comm: bash Not tainted 4.10.0-09601-g0e8f38792120-dirty #112
>> >   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> >   ^^^
>> >
>> > NOTE: This does *NOT* enable or encourage the use of DMI quirks, i.e., the
>> >       the practice of identifying the platform via DMI to decide whether
>> >       certain workarounds for buggy hardware and/or firmware need to be
>> >       enabled. This would require the DMI subsystem to be enabled much
>> >       earlier than we do on ARM, which is non-trivial.
>
> I think that needs to be documented somewhere else other than the commit
> message, although I'm not sure where.
>
>> > Cc: Matt Fleming <matt@codeblueprint.co.uk>
>> > Cc: Russell King <linux@armlinux.org.uk>
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Russell, if you have no objections to this patch, may we have your ack
>> please? I will take it via the EFI tree then.
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>

Thanks. I will copy the NOTE to the Kconfig help text
