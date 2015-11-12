From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 12:31:54 -0800
Subject: [PATCH 01/19] clk: sunxi: Add display clock
In-Reply-To: <20151106233926.GN6114@lukather>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151030212902.GG19782@codeaurora.org>
 <20151106233926.GN6114@lukather>
Message-ID: <20151112203154.GE15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06, Maxime Ripard wrote:
> Hi Stephen,
> 
> Thanks for your feedback!
> 
> On Fri, Oct 30, 2015 at 02:29:02PM -0700, Stephen Boyd wrote:
> > > +
> > > +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > > +	if (!mux)
> > [..]
> > > +		goto free_reset;
> > > +	}
> > > +
> > > +	return;
> > > +
> > > +free_reset:
> > > +	kfree(reset_data);
> > > +free_clk:
> > > +	clk_unregister(clk);
> > 
> > We really ought to have a clk_composite_unregister() API.
> 
> Can we?
> 
> We can always unregister the clock itself, but do we have a way to
> retrieve the structure that has been allocated in there?
> 
> (note that it also applies to the generic clocks registration: muxes,
> dividers, and so on).

Yes we have a way. We've done the same sort of design for other
generic clocks. Do the __clk_get_hw() thing like in clk-divider.c

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
