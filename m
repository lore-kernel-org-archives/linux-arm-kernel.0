From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 May 2018 14:17:41 +0100
Subject: [PATCH v9 01/15] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <1526901932-9514-2-git-send-email-ilialin@codeaurora.org>
References: <1526901932-9514-1-git-send-email-ilialin@codeaurora.org>
 <1526901932-9514-2-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180521131740.GI19713@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 02:25:18PM +0300, Ilia Lin wrote:
> The driver provides kernel level API for other drivers
> to access the MSM8996 L2 cache registers.
> Separating the L2 access code from the PMU driver and
> making it public to allow other drivers use it.
> The accesses must be separated with a single spinlock,
> maintained in this driver.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/perf/Kconfig                 |  1 +
>  drivers/perf/qcom_l2_pmu.c           | 90 ++++++++++--------------------------

I'm fine with the perf bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
