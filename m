From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 21 Sep 2016 12:37:49 +0200
Subject: [PATCH v10 0/4] ACPI: parse the SPCR table
In-Reply-To: <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
Message-ID: <20160921103749.GA7993@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 01:27:30PM +0300, Aleksey Makarov wrote:
> 
> 
> On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> > 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port Console
> > Redirection Table) [2] as a mandatory ACPI table that specifies the
> > configuration of serial console.
> > 
> > Move "earlycon" early_param handling to earlycon.c to parse this option once
> > 
> > Parse SPCR table, setup earlycon and register specified console.
> > 
> > Enable parsing this table on ARM64.  Earlycon should be set up as early as
> > possible.  ACPI boot tables are mapped in
> > arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch() and
> > that's where we parse spcr.  So it has to be opted-in per-arch. When
> > ACPI_SPCR_TABLE is defined initialization of DT earlycon is deferred until the
> > DT/ACPI decision is done.
> > 
> > Implement console_match() for pl011.
> 
> Hi Greg,
> 
> Can you consider picking this series for 4.9 please?

I thought you asked Rafael to take them, they are not in my queue
anymore because of that.  Don't try to shop-around for maintainers
please, that's kind of rude...

greg k-h
