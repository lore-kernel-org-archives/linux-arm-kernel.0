From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Oct 2017 16:04:57 +0100
Subject: [GIT PULL] ACPI IORT changes for v4.15
In-Reply-To: <20171013152937.GA13386@red-moon>
References: <20171013152937.GA13386@red-moon>
Message-ID: <20171016150456.GB10500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Fri, Oct 13, 2017 at 04:29:37PM +0100, Lorenzo Pieralisi wrote:
> Hi Catalin, Will,
> 
> here are the ACPI IORT changes I have queued aimed at the v4.15 kernel
> release.
> 
> Main changes:
> 
> - SMMUv3 MSI enablement work based on IORT issue C spec updates
>   (Hanjun Guo)
> - Clean-ups/rework in preparation for PMCG support (Lorenzo Pieralisi)
> 
> Patches have a compile time dependency on the ACPICA tree that we handled
> through an ACPI_CA_VERSION guard; I will remove it at v4.15-rc1 when
> dependencies have settled.
> 
> Reference discussion:
> 
> http://lkml.kernel.org/r/20171013130445.GA27895 at red-moon
> 
> I expect no merge conflict with the arm64 tree for-next/core branch.
> 
> Patches are based on v4.14-rc4 owing to an IORT dependency on a fix
> (ie commit 37f6b42e9c ("ACPI/IORT: Fix PCI ACS enablement")) that
> was merged in v4.14-rc4.

As discussed offline, given that this is a trivial one-line conflict as
opposed to a functional dependency, could you please send another pull
request based on -rc3? The arm64 for-next/core branch is already based on
that, and this doesn't seem like a good reason to pull in -rc4.

Cheers,

Will
