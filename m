From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Thu, 8 Sep 2016 14:25:26 +0100
Subject: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
In-Reply-To: <20160908111654.GH1493@arm.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
 <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
 <20160908111654.GH1493@arm.com>
Message-ID: <20160908132526.GA2171@xora-monster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:16:55PM +0100, Will Deacon wrote:
> On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
> > 
> > On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> > > SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
> > > 
> > > Earlycon should be set up as early as possible.  ACPI boot tables are
> > > mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
> > > is called from setup_arch() and that's where we parse SPCR.
> > > So it has to be opted-in per-arch.
> > > 
> > > When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
> > > deferred until the DT/ACPI decision is done.  Initialize DT earlycon
> > > if ACPI is disabled.
> > 
> > Hi Will, Catalin,
> > 
> > Can you review this patch and consider ACKing it please?
> 
> Hanjun, Al, Mark, Graeme -- any comments on this?
> 
We have been using this series internally for a long while for boards
with SBSA UART. So IMO it is good to go. We have worked with some OEMs
to fix firmware bugs discovered with this patch series so it should work
with machines in the wild.

Graeme
