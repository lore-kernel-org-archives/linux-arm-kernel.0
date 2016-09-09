From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Sep 2016 16:17:58 +0100
Subject: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
In-Reply-To: <ffcabf79-17b8-f386-32b5-a6052f27f992@linaro.org>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
 <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
 <20160909092958.GB20192@arm.com>
 <ffcabf79-17b8-f386-32b5-a6052f27f992@linaro.org>
Message-ID: <20160909151758.GA11418@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 06:07:04PM +0300, Aleksey Makarov wrote:
> On 09/09/2016 12:29 PM, Will Deacon wrote:
> > On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
> >>
> >> On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> >>> SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
> >>>
> >>> Earlycon should be set up as early as possible.  ACPI boot tables are
> >>> mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
> >>> is called from setup_arch() and that's where we parse SPCR.
> >>> So it has to be opted-in per-arch.
> >>>
> >>> When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
> >>> deferred until the DT/ACPI decision is done.  Initialize DT earlycon
> >>> if ACPI is disabled.
> >>
> >> Hi Will, Catalin,
> >>
> >> Can you review this patch and consider ACKing it please?
> > 
> > Since the ACPI folks seem happy with the series, then:
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > for this patch.
> 
> Thank you.  Can you pull the series?  Should I ask Rafael?

The series should go via Rafael, since the bulk of the changes are
outside of arch/arm64.

Will
