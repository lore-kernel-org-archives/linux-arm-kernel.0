From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 8 May 2017 19:37:06 +0800
Subject: [RFC PATCH 2/3] clk: add managed version of clk_bulk_get
In-Reply-To: <20170422025547.GT7065@codeaurora.org>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-3-git-send-email-aisheng.dong@nxp.com>
 <20170422025547.GT7065@codeaurora.org>
Message-ID: <20170508113706.GC18153@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 07:55:47PM -0700, Stephen Boyd wrote:
> On 04/12, Dong Aisheng wrote:
> > diff --git a/include/linux/clk.h b/include/linux/clk.h
> > index 1d05b66..3fc6010 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -278,11 +278,25 @@ struct clk *clk_get(struct device *dev, const char *id);
> >   *
> >   * clk_bulk_get should not be called from within interrupt context.
> >   */
> > -
> 
> Should be in previous patch?
> 

Yes, will fix.

> >  int __must_check clk_bulk_get(struct device *dev, int num_clks,
> >  			      struct clk_bulk_data *clks);
> >  
> >  /**
> > + * devm_clk_bulk_get - managed get multiple clk consumers
> > + * @dev: device for clock "consumer"
> > + * @num_clks: the number of clk_bulk_data
> > + * @clks: the clk_bulk_data table of consumer
> > + *
> > + * Return 0 on success, an errno on failure.
> > + *
> > + * This helper function allows drivers to get several regulator
> 
> s/regulator/clk/
> 

ditto

> > + * consumers in one operation with management, the clks will
> > + * automatically be freed when the device is unbound.
> > + */
> > +int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
> 
> Thanks for the __must_check. We need to add more __must_check to
> clk APIs.
> 

Yes, just easy to do it from the beginning. :-)

Regards
Dong Aisheng

> > +				   struct clk_bulk_data *clks);
> > +
> > +/**
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
