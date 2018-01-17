From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 Jan 2018 14:33:32 +0100
Subject: [PATCH 1/2] iommu/msm: Claim bus ops on probe
In-Reply-To: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
Message-ID: <20180117133331.vidtyduiu7zr3fwc@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 06:42:30PM +0000, Robin Murphy wrote:
> Since the MSM IOMMU driver now probes via DT exclusively rather than
> platform data, dependent masters should be deferred until the IOMMU
> itself is ready. Thus we can do away with the early initialisation
> hook to unconditionally claim the bus ops, and instead do that only
> once an IOMMU is actually probed. Furthermore, this should also make
> the driver safe for multiplatform kernels on non-MSM SoCs.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied both, thanks Robin.
