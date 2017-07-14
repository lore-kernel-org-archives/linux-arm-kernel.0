From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 13 Jul 2017 18:16:10 -0700
Subject: [PATCH v5 1/2] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <efa06f77-7b0e-9902-dbf1-c76d3203b813@gmail.com>
References: <1499954552-20075-1-git-send-email-gabriel.fernandez@st.com>
 <1499954552-20075-2-git-send-email-gabriel.fernandez@st.com>
 <efa06f77-7b0e-9902-dbf1-c76d3203b813@gmail.com>
Message-ID: <20170714011610.GF22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Florian Fainelli wrote:
> On 07/13/2017 07:02 AM, gabriel.fernandez at st.com wrote:
> > From: Gabriel Fernandez <gabriel.fernandez@st.com>
> > 
> > This patch exposes clk_gate_ops::is_enabled as functions
> > that can be directly called and assigned in places like this so
> > we don't need wrapper functions that do nothing besides forward
> > the call.
> > 
> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > Sugested by Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clk/clk-gate.c       | 2 +-
> >  include/linux/clk-provider.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > index 4e0c054a..e27e28f 100644
> > --- a/drivers/clk/clk-gate.c
> > +++ b/drivers/clk/clk-gate.c
> > @@ -86,7 +86,7 @@ static void clk_gate_disable(struct clk_hw *hw)
> >  	clk_gate_endisable(hw, 0);
> >  }
> >  
> > -static int clk_gate_is_enabled(struct clk_hw *hw)
> > +int clk_gate_is_enabled(struct clk_hw *hw)
> >  {
> >  	u32 reg;
> >  	struct clk_gate *gate = to_clk_gate(hw);
> 
> Don't you need to add an EXPORT_SYMBOL_GPL(clk_gate_is_enabled) as well
> in case this gets used by modules?

It would be needed in the future if someone uses it from a
module. The only user in this patch series looks to be builtin
only. I can add it when applying the patch if there aren't other
comments on the series.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
