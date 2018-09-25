From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 14:09:34 +0200
Subject: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
In-Reply-To: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
Message-ID: <20180925120933.54xd72sv65d63tkl@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> Vivek Gautam (4):
>   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
>   firmware/qcom_scm: Add atomic version of io read/write APIs
>   firmware/qcom_scm: Add scm call to handle smmu errata
>   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> 
>  drivers/firmware/qcom_scm-32.c |  17 ++++
>  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
>  drivers/firmware/qcom_scm.c    |  18 ++++
>  drivers/firmware/qcom_scm.h    |   9 ++
>  drivers/iommu/arm-smmu-regs.h  |   2 +
>  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
>  include/linux/qcom_scm.h       |   6 ++
>  7 files changed, 320 insertions(+), 46 deletions(-)

Should this go through the iommu-tree? In that case I need Acked-by's
for the firmware code changes.

Regards,

	Joerg
