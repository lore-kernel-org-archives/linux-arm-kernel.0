From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jul 2016 21:57:28 +0200
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160713175630.GA2668@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713173804.GA25723@porco> <20160713175630.GA2668@leverpostej>
Message-ID: <7927804.6bj1abO0d2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2016 6:58:32 PM CEST Mark Rutland wrote:
> 
> >   we may want to remove unnecessary devices and even add a dedicated
> >   storage device for storing a core dump image.
> 
> I suspect that bringing up a minimal number of devices is better
> controlled by a cmdline option. In general, figuring out what is
> necessary and what is not is going to be board specific, so hacking the
> FW tables (DTB or ACPI) is not a very portable/reliable approach.
> 
> Do we actually add devices in practice? More so than the above that
> requires special knowledge of the platform (including things that were
> not described in the boot DTB).
> 
> In the ACPI case modifying a DTB alone is not sufficient to change the
> information regarding devices, as those won't be described in the DTB.
> It's not possible to convert ACPI to DTB in general.

A more likely scenario would be replacing ACPI tables with a DTB that
describes the platform in order to use devices that the ACPI tables
don't contain.

> > - Say, booting BE kernel on ACPI LE kernel
> >   In this case, there is no useful dtb in the kernel.

> If the platform only has ACPI, then you cannot boot a BE kernel to begin
> with. As above one cannot convert ACPI to DTB, so one would need
> extensive platform knowledge for this to work.

I think what he meant was to pass a DTB to the kexec kernel in order
to run BE, while the original kernel can only run LE due to ACPI.

If you boot a LE kernel using DTB, the same DTB should work
for a kexec boot for a BE kernel.

	Arnd
