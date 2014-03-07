From: agross@codeaurora.org (Andy Gross)
Date: Fri, 7 Mar 2014 17:11:08 -0600
Subject: [Patch v8 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1393839482.28803.118.camel@smile.fi.intel.com>
References: <1393828245-18766-1-git-send-email-agross@codeaurora.org>
 <1393828245-18766-3-git-send-email-agross@codeaurora.org>
 <1393839482.28803.118.camel@smile.fi.intel.com>
Message-ID: <20140307231108.GD3241@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 09:38:03AM +0000, Shevchenko, Andriy wrote:

<snip>

> > +	if (IS_ERR(bdev->bamclk))
> > +		return PTR_ERR(bdev->bamclk);
> > +
> > +	ret = clk_prepare_enable(bdev->bamclk);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "failed to prepare/enable clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = of_property_read_u32(pdev->dev.of_node, "qcom,ee", &bdev->ee);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "Execution environment unspecified\n");
> > +		return ret;
> 
> goto err_disable_clk; ?
> 
> > 
> > +	}
> > +
> > +	ret = bam_init(bdev);
> > +	if (ret)
> > +		return ret;
> 
> Ditto.
> 

Good catch.  I'll fix both of those.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
