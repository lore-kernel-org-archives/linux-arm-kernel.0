From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 14 Feb 2017 08:34:49 -0800
Subject: [PATCH v4 3/4] dmaengine: Add Broadcom SBA RAID driver
In-Reply-To: <1487055112-5185-4-git-send-email-anup.patel@broadcom.com>
References: <1487055112-5185-1-git-send-email-anup.patel@broadcom.com>
 <1487055112-5185-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <CAPcyv4g5PU1EQWq-SCbt0QB=vSaMyafqa-ThJifDxEoQha-6Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 10:51 PM, Anup Patel <anup.patel@broadcom.com> wrote:
> The Broadcom stream buffer accelerator (SBA) provides offloading
> capabilities for RAID operations. This SBA offload engine is
> accessible via Broadcom SoC specific ring manager.
>
> This patch adds Broadcom SBA RAID driver which provides one
> DMA device with RAID capabilities using one or more Broadcom
> SoC specific ring manager channels. The SBA RAID driver in its
> current shape implements memcpy, xor, and pq operations.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/dma/Kconfig        |   13 +
>  drivers/dma/Makefile       |    1 +
>  drivers/dma/bcm-sba-raid.c | 1694 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1708 insertions(+)
>  create mode 100644 drivers/dma/bcm-sba-raid.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 263495d..bf8fb84 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -99,6 +99,19 @@ config AXI_DMAC
>           controller is often used in Analog Device's reference designs for FPGA
>           platforms.
>
> +config BCM_SBA_RAID
> +       tristate "Broadcom SBA RAID engine support"
> +       depends on (ARM64 && MAILBOX && RAID6_PQ) || COMPILE_TEST
> +       select DMA_ENGINE
> +       select DMA_ENGINE_RAID
> +       select ASYNC_TX_ENABLE_CHANNEL_SWITCH

I thought you agreed to drop this. Its usage is broken.
