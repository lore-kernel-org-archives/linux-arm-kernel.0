From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jul 2016 17:45:09 +0100
Subject: [PATCH 05/11] arm64: pmu: Add support for probing with ACPI
In-Reply-To: <1466529109-21715-6-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-6-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160706164509.GD31910@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 12:11:43PM -0500, Jeremy Linton wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> In the case of ACPI, the PMU IRQ information is contained in the
> MADT table. Also, since the PMU does not exist as a device in the
> ACPI DSDT table, it is necessary to create a platform device so
> that the appropriate driver probing is triggered.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
> 
> NOTE: Much of the code in pmu_acpi_init() is replaced in patches 0009 and
>       0010 this set. The later version of the patch cleans up most of the
>       possible style/error handling issues that have been pointed out with
>       this version.

I agree with Punit that it would be a lot easier to review this series
if you could fold in the changes to pmu_acpi_init so the sum of the
changes can be viewed in one patch.

Will
