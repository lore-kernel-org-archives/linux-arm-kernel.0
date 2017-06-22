From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jun 2017 18:53:50 +0100
Subject: [PATCH v3 2/3] perf: xgene: Move PMU leaf functions into
 function pointer structure
In-Reply-To: <1496772146-11084-3-git-send-email-hotran@apm.com>
References: <1496772146-11084-1-git-send-email-hotran@apm.com>
 <1496772146-11084-3-git-send-email-hotran@apm.com>
Message-ID: <20170622175349.GE25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 11:02:25AM -0700, Hoan Tran wrote:
> This patch moves PMU leaf functions into a function pointer structure.
> It helps code maintain and expasion easier.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/perf/xgene_pmu.c | 85 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 19 deletions(-)

> -static inline u32 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
> +static inline u64 xgene_pmu_read_counter32(struct xgene_pmu_dev *pmu_dev,
> +					   int idx)
>  {
> -	return readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
> +	return (u64)readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
>  }

Nit: the cast is redundant, and can go.

Otherwise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
