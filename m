From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:27:22 +0530
Subject: [PATCH v3 11/15] ARM: vexpress/dcscb: do not hardcode number
 of CPUs per cluster
In-Reply-To: <1359445870-18925-12-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-12-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B5942.20307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> If 4 CPUs are assumed, the A15x1-A7x1 model configuration would never
> shut down the initial cluster as the 0xf reset bit mask will never be
> observed.  Let's construct this mask based on the provided information
> in the DCSCB config register for the number of CPUs per cluster.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   arch/arm/mach-vexpress/dcscb.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index f993608944..8d363357ef 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -46,10 +46,12 @@ static arch_spinlock_t dcscb_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>
>   static void __iomem *dcscb_base;
>   static int dcscb_use_count[4][2];
> +static int dcscb_mcpm_cpu_mask[2];
s/2/MAX_CLUSTERS ?

Apart from above minor question,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
