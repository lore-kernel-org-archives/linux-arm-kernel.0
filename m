From: joe@perches.com (Joe Perches)
Date: Mon, 01 Jun 2015 09:32:30 -0700
Subject: [PATCHv4 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1433175507-3833-3-git-send-email-moritz.fischer@ettus.com>
References: <1433175507-3833-1-git-send-email-moritz.fischer@ettus.com>
 <1433175507-3833-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1433176350.4861.21.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-01 at 09:18 -0700, Moritz Fischer wrote:
> The Xilinx LogiCORE IP mailbox is a FPGA core that allows for
> interprocessor communication via AXI4 memory mapped / AXI4 stream
> interfaces.

trivia:

> diff --git a/drivers/mailbox/mailbox-xilinx.c b/drivers/mailbox/mailbox-xilinx.c
[]
> +static int xilinx_mbox_startup(struct mbox_chan *chan)
> +{
[]
> +			dev_err(mbox->dev,
> +				"failed to register mailbox interrupt:%d\n",
> +				ret);
[]
> +static int xilinx_mbox_probe(struct platform_device *pdev)
> +{
[]
> +		dev_err(&pdev->dev, "Couldn't get clk.\n");
[]
> +		dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
[]
> +		dev_err(&pdev->dev, "Register mailbox failed\n");

Perhaps it' be nicer to consistently use a "no-period"
message style.
