From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 20 Jun 2017 17:26:11 +0800
Subject: [PATCH 3/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
In-Reply-To: <20170620015547.GN4493@codeaurora.org>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-4-git-send-email-aisheng.dong@nxp.com>
 <20170620015547.GN4493@codeaurora.org>
Message-ID: <20170620092611.GC6805@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 06:55:47PM -0700, Stephen Boyd wrote:
> On 05/15, Dong Aisheng wrote:
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index a6efbb9..4466cae 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -557,6 +557,11 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
> >   * @lock:	register lock
> >   *
> >   * Clock with adjustable fractional divider affecting its output frequency.
> > + *
> > + * Flags:
> > + * CLK_FRAC_DIVIDER_ZERO_BASED - by default the divisor is the value read
> > + *	from the register.  If CLK_FRAC_DIVIDER_ZERO_BASED is set then the
> > + *	divider is the raw value read from the register plus one.
> 
> This should say the numerator and denominator are both the value
> read plus one. It isn't clear if it applies to the numerator, or
> the denominator, or both.
> 

Good suggestion.
Will improve it.

Regards
Dong Aisheng

> >   */
> >  struct clk_fractional_divider {
> >  	struct clk_hw	hw;
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
