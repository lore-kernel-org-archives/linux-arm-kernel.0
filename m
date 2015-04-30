From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Apr 2015 14:50:18 +0100
Subject: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
In-Reply-To: <55423261.4050008@linaro.org>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150429140445.GA18867@e104818-lin.cambridge.arm.com>
 <5540EB27.8060507@amd.com>
 <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
 <55423261.4050008@linaro.org>
Message-ID: <20150430135018.GH32373@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 02:47:13PM +0100, Hanjun Guo wrote:
> On 2015?04?29? 22:42, Catalin Marinas wrote:
> > On Wed, Apr 29, 2015 at 09:31:03AM -0500, Suravee Suthikulpanit wrote:
> >> On 04/29/2015 09:04 AM, Catalin Marinas wrote:
> >>> On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit wrote:
> >>> Any plans for ACPI on 32-bit ARM?
> >>
> >> Not that I am aware, but I could be totally wrong. The reason I am adding
> >> this here for 32-bit ARM is because the ACPI spec mentioned this.
> >>
> >> If you think this is not necessary until we introduce ACPI for ARM32, it can
> >> be removed.
> >
> > I think it should be removed (as long as ACPI cannot be selected on
> > arm32).
> 
> I agree.
> 
> Now there is no plan for ARM32 ACPI as I know, ACPI for ARM targets
> for ARM64 based enterprise system at now.

While we're at it, do we *really* need to support CONFIG_ACPI_PROCFS_POWER
on arm64? It's a deprecated /proc/acpi interface and it would be nice to
avoid introducing deprecated behaviour if we can avoid it.

Will
