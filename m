From: agross@codeaurora.org (Andy Gross)
Date: Mon, 21 Apr 2014 12:11:18 -0500
Subject: [PATCH 2/4] soc: qcom: Add GSBI driver
In-Reply-To: <20140421165400.GA11778@joshc.qualcomm.com>
References: <1398058244-14099-1-git-send-email-agross@codeaurora.org>
 <1398058244-14099-3-git-send-email-agross@codeaurora.org>
 <20140421165400.GA11778@joshc.qualcomm.com>
Message-ID: <20140421171117.GB32485@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 11:54:00AM -0500, Josh Cartwright wrote:

<snip>

> > +
> > +struct gsbi_dev {
> > +	struct device	*dev;
> > +	void __iomem	*base;
> 
> You don't really need these.

Old habits die hard.  I'll remove.

<snip>

> > +	if (of_property_read_u32(node, "qcom,mode", &mode)) {
> > +		dev_err(gsbi->dev, "missing mode configuration\n");
> > +		return -EINVAL;
> > +	}
> 
> I'm wondering if you should really be a (very simple) pinctrl driver
> proper.

Perhaps.  But how would i reconcile more than one device node that uses the same
GSBI?  One could still trounce the other unless I only allow one setting of the
GSBI.

<snip>

> > +	clk_prepare_enable(gsbi->hclk);
> > +
> > +	writel_relaxed((mode << GSBI_PROTOCOL_SHIFT), gsbi + GSBI_CTRL_REG);
> 
> Did you mean: gsbi->base + GSBI_CTRL_REG ?

Ouch, how did this get munged.  I'll fix this on resend.

<snip>

> > +
> > +static struct of_device_id gsbi_dt_match[] = {
> 
> const

Will fix.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
