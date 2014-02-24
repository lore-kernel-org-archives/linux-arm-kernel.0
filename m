From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 24 Feb 2014 10:00:41 -0800
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <5306BFC4.5000005@elopez.com.ar>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <5306BFC4.5000005@elopez.com.ar>
Message-ID: <20140224180040.GC32621@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 20 Feb 18:53 PST 2014, Emilio L?pez wrote:

> Hi Bjorn,
> 
> El 20/02/14 21:38, Bjorn Andersson escribi?:
[...]
> > +	clk_freq = 100000;
> > +	if (!of_property_read_u32(node, "clock-frequency", &val))
> > +		clk_freq = val;
> 
> val will be modified only if no error occurs, so you may rewrite this 
> bit as
> 
> +	u32 clk_freq = 100000;
> ...
> +	of_property_read_u32(node, "clock-frequency", &clk_freq)

Seems the two conventions used in the kernel is either your proposal or "if
fail the assign default". So I'll change this.

> 
> > +
> > +	/* We support frequencies up to FAST Mode (400KHz) */
> > +	if (clk_freq <= 0 || clk_freq > 400000) {
> 
> And you can drop the < check when it's unsigned.

Indeed!

> 
> > +		dev_err(qup->dev, "clock frequency not supported %d\n",
> > +			clk_freq);
> > +		return -EIO;
> 
> EIO?

EINVAL

> 
> Cheers,
> 
> Emilio

Thanks,
Bjorn
