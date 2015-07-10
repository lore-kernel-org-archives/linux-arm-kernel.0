From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Jul 2015 15:48:14 +0100
Subject: ACPI: regression: Failed to initialize GIC IRQ controller
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
References: <CACVXFVPkZYm2i+S3m8B0tixKmTx02psGndo79ehdJxLiz9T92A@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
Message-ID: <20150710144814.GA12489@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 03:28:36PM +0100, Moore, Robert wrote:
> 
> 
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei at canonical.com]
> > Sent: Friday, July 10, 2015 12:46 AM
> > To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
> > Cc: Linux Kernel Mailing List; linux-arm-kernel; Thomas Gleixner; Jason
> > Cooper; Hanjun Guo
> > Subject: ACPI: regression: Failed to initialize GIC IRQ controller
> > 
> > Hi,
> > 
> > Commit 0cff8dc0099f6d4f(ACPICA: ACPI 6.0: Add changes for MADT table.)
> > causes the following failure on APM mustang board(arm64) when booting via
> > UEFI and ACPI:
> 
> 
> I would be interested to know just what exactly about this change broke things.

struct acpi_madt_generic_interrupt gained 4 bytes, 4 too many for ACPI
on ARM64 to boot with 5.1 tables.

>From now onwards we have to test acpica changes against the arm64 kernel
tree, this must not happen again.

See below:

https://lkml.org/lkml/2015/7/6/876

Thanks,
Lorenzo

> Bob
> 
> 
> 
> > 
> > No valid GICC entries exist
> > ACPI: Failed to initialize GIC IRQ controller Kernel panic - not syncing:
> > No interrupt controller found.
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc1+ #45 Hardware name:
> > APM X-Gene Mustang board (DT) Call trace:
> > [<ffffffc000089b94>] dump_backtrace+0x0/0x12c [<ffffffc000089cd0>]
> > show_stack+0x10/0x1c [<ffffffc0005fac18>] dump_stack+0x8c/0xdc
> > [<ffffffc0005f7218>] panic+0xe4/0x220 [<ffffffc00082631c>]
> > init_IRQ+0x24/0x30 [<ffffffc00082486c>] start_kernel+0x274/0x3d8 ---[ end
> > Kernel panic - not syncing: No interrupt controller found.
> > 
> > 
> > Thanks,
> > Ming
> N???????????????r??????y?????????b???X????????v???^???)??{.n???+????????????{????????????zX??????????????}???????????z???&j:+v?????????????????????zZ+??????+zf?????????h?????????~????????????i?????????z???
???w??????????????????????&???)??f??????^j??y???m??????@A???a?????????
0??????h??????i
