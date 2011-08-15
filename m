From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 15 Aug 2011 19:45:48 +0530
Subject: [PATCH 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
In-Reply-To: <1311744697-10264-8-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-8-git-send-email-boojin.kim@samsung.com>
Message-ID: <CAJuYYwT0R+VXWvWuV6KK=m_knoxBnBf=GLVimPoe002mcvqqeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boojin,

On 27 July 2011 11:01, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch makes Samsung EXYNOS4 to use DMA PL330 driver
> on DMADEVICE. The EXYNOS4 uses DMA generic APIs instead of
> SAMSUNG specific S3C-PL330 APIs.
>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Kconfig | ? ?2 +-
> ?arch/arm/mach-exynos4/clock.c | ? 16 ++-
> ?arch/arm/mach-exynos4/dma.c ? | ?299 ++++++++++++++++++++++++++---------------
> ?3 files changed, 198 insertions(+), 119 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
> index 564bb53..d57d662 100644

[...]

> +struct dma_pl330_peri pdma0_peri[28] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM0_RX,
> + ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
> + ? ? ? }, {

The client driver specifies the direction of the transfer
(DMA_TO_DEVICE or DMA_FROM_DEVICE) when requesting for a dma channel.
So, is the rqtype parameter required in the platform data for the dma
driver?

Thanks,
Thomas.
