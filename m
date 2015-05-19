From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 May 2015 10:03:13 +0100
Subject: [PATCHv2 00/12] arm/arm64: Unify PSCI client support
In-Reply-To: <20150518174957.GT21251@e104818-lin.cambridge.arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <20150518174957.GT21251@e104818-lin.cambridge.arm.com>
Message-ID: <20150519090313.GA11175@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 06:49:57PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2015 at 11:38:11AM +0100, Mark Rutland wrote:
> > This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
> > the FW invocation and probing out to a common locaiton in drivers/firmware.
> > As part of this, the remaining edge cases for PSCI 0.2 (Trusted OSs rejecting
> > CPU_OFF) are accounted for, maknig both 32-bit adn 64-bit clients more robust.
> > 
> > This results in a reasonable saving in terms of lines of code, and will allow
> > for PSCI 1.0 support to be unified form the beginning, avoiding further
> > duplication.
> > 
> > The series is based on v4.1-rc3.
> > 
> > Since v1 [1]:
> > * Fix build when PSCI isn't selected
> > * Don't indirect migrate_info_up_cpu
> > * Fix ver to u32 in psci_get_version
> > 
> > Thanks,
> > Mark.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/341770.html
> > 
> > Mark Rutland (12):
> >   arm/arm64: kvm: add missing PSCI include
> >   arm64: smp_plat: add get_logical_index
> >   arm64: smp: consistently use error codes
> >   arm64: psci: remove unnecessary id indirection
> >   arm64: psci: support unsigned return values
> >   arm64: psci: account for Trusted OS instances
> >   arm64: psci: kill psci_power_state
> >   arm64: psci: remove ACPI coupling
> >   arm64: psci: factor invocation code to drivers
> >   drivers: psci: support native SMC{32,64} calls
> >   ARM: migrate to common PSCI client code
> >   MAINTAINERS: add PSCI entry
> 
> So, apart from some comments I had, the series looks fine.
> 
> How do you plan to merge this? I'm happy for it to go through the
> arm-soc tree (hopefully there are no conflicts with some of Lorenzo's
> patches for the unification of ACPI/DT CPU initialisation).

Unfortunately I think there are (minor, owing to PSCI headers reshuffling,
but to be sorted out), let me know please the preferred way to merge the
two sets.

Thanks,
Lorenzo
