From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Jun 2017 10:27:45 +0100
Subject: [PATCH v3] iommu/arm-smmu: Plumb in new ACPI identifiers
In-Reply-To: <063a50cff2942c96dc6f24d4f8c8a854a4a6cc30.1497886335.git.robin.murphy@arm.com>
References: <063a50cff2942c96dc6f24d4f8c8a854a4a6cc30.1497886335.git.robin.murphy@arm.com>
Message-ID: <20170621092744.GG3768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 04:41:56PM +0100, Robin Murphy wrote:
> Revision C of IORT now allows us to identify ARM MMU-401 and the Cavium
> ThunderX implementation. Wire them up so that we can probe these models
> once firmware starts using the new codes in place of generic ones, and
> so that the appropriate features and quirks get enabled when we do.
> 
> For the sake of backports and mitigating sychronisation problems with
> the ACPICA headers, we'll carry a backup copy of the new definitions
> locally for the short term to make life simpler.
> 
> CC: stable at vger.kernel.org # 4.10
> Acked-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: The patch that actually landed in ACPICA was slightly tweaked for
>     self-consistency, so s/CAVIUM_SMMUV2/CAVIUM_THUNDERX/ to match.
> 
>  drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I've picked this one up.

Will
