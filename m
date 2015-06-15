From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 15 Jun 2015 20:35:17 +0530
Subject: [PATCH v2 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <1434378982-30184-2-git-send-email-punnaia@xilinx.com>
References: <1434378982-30184-1-git-send-email-punnaia@xilinx.com>
 <1434378982-30184-2-git-send-email-punnaia@xilinx.com>
Message-ID: <CAM=Q2ctpOhxryYqgiHDQry7Q_1noYGEX4pYg+tp+wLgV9=X1hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 8:06 PM, Punnaiah Choudary Kalluri
<punnaiah.choudary.kalluri@xilinx.com> wrote:
> Added the basic driver for zynqmp dma engine used in Zynq
> UltraScale+ MPSoC. The initial release of this driver supports
> only memory to memory transfers.
>
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
<snip>

> +/**
> + * zynqmp_dma_chan_is_idle - Provides the channel idle status
> + * @chan: ZynqMP DMA DMA channel pointer
> + *
> + * Return: '1' if the channel is idle otherwise '0'
> + */
> +static int zynqmp_dma_chan_is_idle(struct zynqmp_dma_chan *chan)

maybe this could return bool.

> +{
> +       u32 regval;
> +
> +       regval = readl(chan->regs + STATUS);
> +       if (regval & STATUS_BUSY)
> +               return 0;
> +
> +       return 1;
> +}
> +
