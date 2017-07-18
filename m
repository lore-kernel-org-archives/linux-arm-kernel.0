From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Jul 2017 15:52:03 -0700
Subject: [PATCH v6 2/3] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <55bc0f3f-67ed-a15f-5b71-d87044fd5237@mleia.com>
References: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
 <1500364414-10021-3-git-send-email-gabriel.fernandez@st.com>
 <55bc0f3f-67ed-a15f-5b71-d87044fd5237@mleia.com>
Message-ID: <20170718225203.GD18179@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18, Vladimir Zapolskiy wrote:
> On 07/18/2017 10:53 AM, gabriel.fernandez at st.com wrote:
> > From: Gabriel Fernandez <gabriel.fernandez@st.com>
> >  }
> > +EXPORT_SYMBOL_GPL(clk_gate_is_enabled);
> >  
> >  const struct clk_ops clk_gate_ops = {
> >  	.enable = clk_gate_enable,
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index c59c625..e9587ab 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -343,6 +343,7 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
> >  		u8 clk_gate_flags, spinlock_t *lock);
> >  void clk_unregister_gate(struct clk *clk);
> >  void clk_hw_unregister_gate(struct clk_hw *hw);
> > +int clk_gate_is_enabled(struct clk_hw *hw);
> 
> Here the prefix does not reflect the type of its argument, it might be
> acceptable for a veiled function, but it is not wanted for the exported
> function. Something like clk_hw_gate_is_enabled() is expected here, but
> again, let's firstly come to an agreement, that the export is needed.
> 

I'd prefer clk_gate_is_enabled() as it's not a struct
clk_hw_gate, it's a struct clk_gate and there isn't any
requirement for function names to reflect the type of the
argument. That's what we have type analysis for.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
