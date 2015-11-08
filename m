From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 7 Nov 2015 23:02:33 -0600
Subject: [PATCH V3 1/4] dma: qcom_bam_dma: move to qcom directory
In-Reply-To: <1446958380-23298-2-git-send-email-okaya@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-2-git-send-email-okaya@codeaurora.org>
Message-ID: <563ED769.6020706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
> Creating a QCOM directory for all QCOM DMA
> source files.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/dma/Kconfig        |   13 +-
>   drivers/dma/Makefile       |    2 +-
>   drivers/dma/qcom/Kconfig   |    9 +
>   drivers/dma/qcom/Makefile  |    1 +
>   drivers/dma/qcom/bam_dma.c | 1259 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/dma/qcom_bam_dma.c | 1259 --------------------------------------------
>   6 files changed, 1273 insertions(+), 1270 deletions(-)
>   create mode 100644 drivers/dma/qcom/Kconfig
>   create mode 100644 drivers/dma/qcom/Makefile
>   create mode 100644 drivers/dma/qcom/bam_dma.c
>   delete mode 100644 drivers/dma/qcom_bam_dma.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index b458475..d17d9ec 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -320,7 +320,7 @@ config MOXART_DMA
>   	select DMA_VIRTUAL_CHANNELS
>   	help
>   	  Enable support for the MOXA ART SoC DMA controller.
> -
> +

Unrelated whitespace change.

> diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
> new file mode 100644
> index 0000000..f612ae3
> --- /dev/null
> +++ b/drivers/dma/qcom/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> new file mode 100644
> index 0000000..5359234

Please use "git format-patch -M" when creating patches for files that 
have moved.



-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
