From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 20 Apr 2016 11:39:02 -0700
Subject: [PATCH 2/2] dmaengine: vdma: Add clock support
In-Reply-To: <1461136800-20334-2-git-send-email-appanad@xilinx.com>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
 <1461136800-20334-2-git-send-email-appanad@xilinx.com>
Message-ID: <CAAtXAHd=QER9ukD8LKpHCGdmsv=MzJ4bxkvWVEatpfUhsh98SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for looking into this.

On Wed, Apr 20, 2016 at 12:20 AM, Kedareswara rao Appana
<appana.durga.rao@xilinx.com> wrote:

> +static int xdma_clk_init(struct xilinx_dma_device *xdev, bool enable)
> +{
> +       int i = 0, ret;
> +
> +       for (i = 0; i < xdev->numclks; i++) {
> +               if (enable) {
> +                       ret = clk_prepare_enable(xdev->clks[i]);
> +                       if (ret) {
> +                               dev_err(xdev->dev,
> +                                       "failed to enable the axidma clock\n");
> +                               return ret;

What happens to the ones you already turned on, if say the third fails?

Cheers,

Moritz
