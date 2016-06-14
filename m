From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jun 2016 15:11:48 +0100
Subject: [PATCH v2 1/7] iommu/of: Respect disabled IOMMUs
In-Reply-To: <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
Message-ID: <20160614141148.GH19407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 06:15:36PM +0100, Robin Murphy wrote:
> If an IOMMU node is present in the DT but marked as disabled, we should
> avoid trying to do anything with it. We currently sort-of get away with
> this by virtue of a disabled device probably not having called
> of_iommu_set_ops(), but that is hardly safe to rely upon in general, and
> either way we don't want to treat it as an error condition with the
> resulting "Failed to initialise IOMMU" message.

What's the use-case for this? I ask because epapr says that the device
binding should provide details as to exactly what "disabled" means for
that device.

Will
