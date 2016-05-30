From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Mon, 30 May 2016 11:47:01 +0530
Subject: [PATCH v9 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <1463123033-5443-2-git-send-email-appanad@xilinx.com>
References: <1463123033-5443-1-git-send-email-appanad@xilinx.com>
 <1463123033-5443-2-git-send-email-appanad@xilinx.com>
Message-ID: <CAKfKVtE-2rYVmCK1OOzitayH7AzUQHnspoEv6RBLCxUJVnVksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + */
> +static void zynqmp_dma_update_desc_to_ctrlr(struct zynqmp_dma_chan *chan,
> +                                     struct zynqmp_dma_desc_sw *desc)
> +{
> +       dma_addr_t addr;
> +
> +       addr = desc->src_p;
> +       writel(addr, chan->regs + ZYNQMP_DMA_SRC_START_LSB);
> +       writel(upper_32_bits(addr), chan->regs + ZYNQMP_DMA_SRC_START_MSB);
Can we combine the two writes to a 64bit write.
It may be helpful on 64-bit systems.


> +       addr = desc->dst_p;
> +       writel(addr, chan->regs + ZYNQMP_DMA_DST_START_LSB);
> +       writel(upper_32_bits(addr), chan->regs + ZYNQMP_DMA_DST_START_MSB);
> +}
