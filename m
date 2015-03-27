From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 27 Mar 2015 09:48:34 +0800
Subject: [PATCH 1/4] clk: hisi: add API for allocation clk data struct
In-Reply-To: <20150326141834.GI8656@n2100.arm.linux.org.uk>
References: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
 <1427368419-22222-2-git-send-email-leo.yan@linaro.org>
 <20150326141834.GI8656@n2100.arm.linux.org.uk>
Message-ID: <20150327014834.GA4902@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell,

On Thu, Mar 26, 2015 at 02:18:34PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 26, 2015 at 07:13:36PM +0800, Leo Yan wrote:
> > +struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
> > +					     int nr_clks)
> > +{
> > +	struct hisi_clock_data *clk_data;
> > +	void __iomem *base;
> > +
> > +	if (np) {
> > +		base = of_iomap(np, 0);
> > +		if (!base) {
> > +			pr_err("failed to map Hisilicon clock registers\n");
> > +			return NULL;
> > +		}
> > +		printk("%s: base %p\n", __func__, base);
> 
> Did you leave your debugging in?

Sorry, will remove it.

> > +	} else {
> > +		pr_err("failed to find Hisilicon clock node in DTS\n");
> > +		return NULL;
> > +	}
> 
> I know you're mostly only moving this code, but it would be far better if
> it were written:
> 
> 	if (!np) {
> 		pr_err("failed to find Hisilicon clock node in DTS\n");
> 		return NULL;
> 	}
> 
> 	base = of_iomap(np, 0);
> 	if (!base) {
> 		pr_err("failed to map Hisilicon clock registers\n");
> 		return NULL;
> 	}
> 
> Possibly do this first as a separate patch, and then move the code.

Will do this.

> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
