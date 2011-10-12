From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 12 Oct 2011 12:58:03 +0900
Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330
	driver
In-Reply-To: <1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
Message-ID: <000701cc8893$246a2d50$6d3e87f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> Sent: Tuesday, October 11, 2011 3:16 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com;
> vinod.koul at intel.com; Jassi Brar; Boojin Kim
> Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330
> driver
>
> With the 'struct dma_pl330_peri' removed, the platfrom data for dma
> driver can be simplified to a simple list of peripheral request ids.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-s5pc100/dma.c |  247 ++++++++++++-----------------------
> --------
>  1 files changed, 69 insertions(+), 178 deletions(-)
>

Looks good to me.
Acked-by: Boojin Kim <boojin.kim@samsung.com>

> diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
> index 065a087..8dfdc76 100644
> --- a/arch/arm/mach-s5pc100/dma.c
> +++ b/arch/arm/mach-s5pc100/dma.c
> @@ -35,100 +35,42 @@
>
>  static u64 dma_dmamask = DMA_BIT_MASK(32);
>
