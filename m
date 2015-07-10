From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Jul 2015 16:17:40 +0100
Subject: ACPI: regression: Failed to initialize GIC IRQ controller
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B2E9@ORSMSX112.amr.corp.intel.com>
References: <CACVXFVPkZYm2i+S3m8B0tixKmTx02psGndo79ehdJxLiz9T92A@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
 <CACVXFVPjRiE55ndUY8PrGt6Qjnj1M_cJ5De=PDuRF-mz9NpAvg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B2E9@ORSMSX112.amr.corp.intel.com>
Message-ID: <20150710151740.GB12489@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 03:45:32PM +0100, Moore, Robert wrote:
> It's nice that someone took a sizeof() on the struct -- so, one would hope that no code actually depended on a particular value, no?

Unfortunately that sizeof has been there forever (x86/ia64),
ia64 code ran into a similar issue, so the check was removed
to cope with lsapic MADT updates, see:

arch/ia64/kernel/acpi.c line 204

/*Skip BAD_MADT_ENTRY check, as lsapic size could vary */

Is checking the subtable length field against a static value
really worthwhile/suitable ?

Thanks,
Lorenzo

> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei at canonical.com]
> > Sent: Friday, July 10, 2015 7:43 AM
> > To: Moore, Robert
> > Cc: Zheng, Lv; Wysocki, Rafael J; Linux Kernel Mailing List; linux-arm-
> > kernel; Thomas Gleixner; Jason Cooper; Hanjun Guo
> > Subject: Re: ACPI: regression: Failed to initialize GIC IRQ controller
> > 
> > On Fri, Jul 10, 2015 at 10:28 PM, Moore, Robert <robert.moore@intel.com>
> > wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Ming Lei [mailto:ming.lei at canonical.com]
> > >> Sent: Friday, July 10, 2015 12:46 AM
> > >> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
> > >> Cc: Linux Kernel Mailing List; linux-arm-kernel; Thomas Gleixner;
> > >> Jason Cooper; Hanjun Guo
> > >> Subject: ACPI: regression: Failed to initialize GIC IRQ controller
> > >>
> > >> Hi,
> > >>
> > >> Commit 0cff8dc0099f6d4f(ACPICA: ACPI 6.0: Add changes for MADT
> > >> table.) causes the following failure on APM mustang board(arm64) when
> > >> booting via UEFI and ACPI:
> > >
> > >
> > > I would be interested to know just what exactly about this change broke
> > things.
> > 
> > sizeof(struct acpi_madt_generic_interrupt)
> N???????????????r??????y?????????b???X????????v???^???)??{.n???+????????????{????????????zX??????????????}???????????z???&j:+v?????????????????????zZ+??????+zf?????????h?????????~????????????i?????????z???
???w??????????????????????&???)??f??????^j??y???m??????@A???a?????????
0??????h??????i
