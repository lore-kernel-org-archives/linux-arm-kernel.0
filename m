From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 21 Oct 2014 09:06:13 +0000
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <4301925.4pMHXMXqA4@wuerfel>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <4301925.4pMHXMXqA4@wuerfel>
Message-ID: <ff137744d6474640aab09e5d6f62921a@BN1AFFO11FD019.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

-----Original Message-----
From: Arnd Bergmann [mailto:arnd at arndb.de]
Sent: Tuesday, October 21, 2014 1:07 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Srikanth Thokala; vinod.koul at intel.com; dan.j.williams at intel.com; Michal Simek; grant.likely at linaro.org; robh+dt at kernel.org; devicetree at vger.kernel.org; Srikanth Vemula; linux-kernel at vger.kernel.org; Anirudha Sarangi; dmaengine at vger.kernel.org; Appana Durga Kedareswara Rao
Subject: Re: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine driver support

On Wednesday 15 October 2014 17:30:36 Srikanth Thokala wrote:
> @@ -15,6 +15,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>
> +/* Number of AXI DMA APP Words */
> +#define XILINX_DMA_NUM_APP_WORDS       5
> +
>  /**
>   * struct xilinx_vdma_config - VDMA Configuration structure
>   * @frm_dly: Frame delay
> @@ -41,7 +44,21 @@ struct xilinx_vdma_config {
>         int ext_fsync;
>  };
>
> +/**
> + * struct xilinx_dma_config - DMA Configuration structure
> + * @coalesc: Interrupt coalescing threshold
> + * @delay: Delay counter
> + * @reset: Reset Channel
> + */
> +struct xilinx_dma_config {
> +       int coalesc;
> +       int delay;
> +       int reset;
> +};
> +
>  int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
>                                         struct xilinx_vdma_config
> *cfg);
> +int xilinx_dma_channel_set_config(struct dma_chan *dchan,
> +                                       struct xilinx_dma_config
> +*cfg);
>

You add this to a global header file, but I don't see any uses outside of the driver itself. Please move all of this into the driver itself and remove the header file.

        Arnd

The above mentioned API's  and structures will be used by the dma test client driver's to set hardware configuration information. The dma client drivers are not mainlined  yet and it is
Internally used by  our git-tree  to test the DMA functionality in loopback .

Regards,
Kedar.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
