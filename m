From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 May 2015 13:23:58 +0100
Subject: [PATCHv3 00/12] arm/arm64: Unify PSCI client support
In-Reply-To: <55657B9B.5010206@linaro.org>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <55657B9B.5010206@linaro.org>
Message-ID: <20150527122358.GG8439@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 09:08:59AM +0100, Hanjun Guo wrote:
> On 2015?05?26? 21:52, Mark Rutland wrote:
> > This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
> > the FW invocation and probing out to a common location in drivers/firmware.
> > As part of this, the remaining edge cases for PSCI 0.2 (Trusted OSs rejecting
> > CPU_OFF) are accounted for, making both 32-bit adn 64-bit clients more robust.
> >
> > This results in a reasonable saving in terms of lines of code, and will allow
> > for PSCI 1.0 support to be unified form the beginning, avoiding further
> > duplication.
> >
> > The series is based on the arm64 for-next/cpu-init branch [3] due to conflicts
> > with that series.
> >
> > Since v1 [1]:
> > * Fix build when PSCI isn't selected
> > * Don't indirect migrate_info_up_cpu
> > * Fix ver to u32 in psci_get_version
> >
> > Since v2: [2]:
> > * Rebase atop of Lorenzo's cpu init cleanup series [3]
> > * Use the correct native function IDs
> > * Fix cpu_disable return values
> > * Report invalid MIGRATE_INFO_UP_CPU return values
> >
> > Many thanks to those who have reviewed and tested so far! Unfortunately, due to
> > the volume of changes in the rebase I've dropped all Tested-by tags. I've
> > locally tested 32-bit and 64-bit kernels with DT.
> 
> I tested this patch set on ARM64 kernel with ACPI as I did in previous
> version, compile this patch set ok with CONFIG_ACPI=y/n, and CPU
> hotplug works with PSCI (CPU_ON/OFF),
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks!

I've applied that to the first 10 patches, but not to the patch
affecting 32-bit ARM nor the patch updating MAINTAINERS.

Mark.
