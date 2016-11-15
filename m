From: mbrugger@suse.com (Matthias Brugger)
Date: Tue, 15 Nov 2016 12:05:15 +0100
Subject: [PATCH fpga 1/9] fpga zynq: Add missing \n to messages
In-Reply-To: <1478732303-13718-2-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-2-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <0aebdb59-86d7-2569-c49d-de5d45b5cac0@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/11/16 23:58, Jason Gunthorpe wrote:
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Please add a commit message, although it is cristal clear what this 
patch does :)

Regards,
Matthias

> ---
>  drivers/fpga/zynq-fpga.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index c2fb4120bd62..e72340ea7323 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -217,7 +217,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  					     INIT_POLL_DELAY,
>  					     INIT_POLL_TIMEOUT);
>  		if (err) {
> -			dev_err(priv->dev, "Timeout waiting for PCFG_INIT");
> +			dev_err(priv->dev, "Timeout waiting for PCFG_INIT\n");
>  			goto out_err;
>  		}
>
> @@ -231,7 +231,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  					     INIT_POLL_DELAY,
>  					     INIT_POLL_TIMEOUT);
>  		if (err) {
> -			dev_err(priv->dev, "Timeout waiting for !PCFG_INIT");
> +			dev_err(priv->dev, "Timeout waiting for !PCFG_INIT\n");
>  			goto out_err;
>  		}
>
> @@ -245,7 +245,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  					     INIT_POLL_DELAY,
>  					     INIT_POLL_TIMEOUT);
>  		if (err) {
> -			dev_err(priv->dev, "Timeout waiting for PCFG_INIT");
> +			dev_err(priv->dev, "Timeout waiting for PCFG_INIT\n");
>  			goto out_err;
>  		}
>  	}
> @@ -262,7 +262,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  	/* check that we have room in the command queue */
>  	status = zynq_fpga_read(priv, STATUS_OFFSET);
>  	if (status & STATUS_DMA_Q_F) {
> -		dev_err(priv->dev, "DMA command queue full");
> +		dev_err(priv->dev, "DMA command queue full\n");
>  		err = -EBUSY;
>  		goto out_err;
>  	}
> @@ -331,7 +331,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>  	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
>
>  	if (!((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
> -		dev_err(priv->dev, "Error configuring FPGA");
> +		dev_err(priv->dev, "Error configuring FPGA\n");
>  		err = -EFAULT;
>  	}
>
> @@ -426,7 +426,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	priv->slcr = syscon_regmap_lookup_by_phandle(dev->of_node,
>  		"syscon");
>  	if (IS_ERR(priv->slcr)) {
> -		dev_err(dev, "unable to get zynq-slcr regmap");
> +		dev_err(dev, "unable to get zynq-slcr regmap\n");
>  		return PTR_ERR(priv->slcr);
>  	}
>
> @@ -434,26 +434,26 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>
>  	priv->irq = platform_get_irq(pdev, 0);
>  	if (priv->irq < 0) {
> -		dev_err(dev, "No IRQ available");
> +		dev_err(dev, "No IRQ available\n");
>  		return priv->irq;
>  	}
>
>  	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0,
>  			       dev_name(dev), priv);
>  	if (err) {
> -		dev_err(dev, "unable to request IRQ");
> +		dev_err(dev, "unable to request IRQ\n");
>  		return err;
>  	}
>
>  	priv->clk = devm_clk_get(dev, "ref_clk");
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "input clock not found");
> +		dev_err(dev, "input clock not found\n");
>  		return PTR_ERR(priv->clk);
>  	}
>
>  	err = clk_prepare_enable(priv->clk);
>  	if (err) {
> -		dev_err(dev, "unable to enable clock");
> +		dev_err(dev, "unable to enable clock\n");
>  		return err;
>  	}
>
> @@ -465,7 +465,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>  				&zynq_fpga_ops, priv);
>  	if (err) {
> -		dev_err(dev, "unable to register FPGA manager");
> +		dev_err(dev, "unable to register FPGA manager\n");
>  		clk_unprepare(priv->clk);
>  		return err;
>  	}
>
