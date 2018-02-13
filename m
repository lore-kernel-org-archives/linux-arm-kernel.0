From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 13 Feb 2018 19:33:30 +0100
Subject: [PATCH 1/1] iommu/io-pgtable: use size_t return type for all
 foo_unmap
In-Reply-To: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20180213183330.6su6gc3uctpvaa2e@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 11:29:19PM +0530, Vivek Gautam wrote:
> Unmap returns a size_t all throughout the IOMMU framework.
> Make io-pgtable match this convention.
> Moreover, there isn't a need to have a signed int return type
> as we return 0 in case of failures.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 21 +++++++++++----------
>  drivers/iommu/io-pgtable-arm.c     | 24 ++++++++++++------------
>  drivers/iommu/io-pgtable.h         |  4 ++--
>  3 files changed, 25 insertions(+), 24 deletions(-)

Applied, thanks.
