From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 May 2016 15:15:41 -0700
Subject: [linux-sunxi] Re: [PATCH v4 01/11] clk: sunxi: Add display and
 TCON0 clocks driver
In-Reply-To: <1462907459.9981.0.camel@plaes.org>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160506223002.GE3492@codeaurora.org>
 <20160508200308.GF6167@lukather>
 <20160509223238.GW3492@codeaurora.org>
 <20160509223924.GX3492@codeaurora.org>
 <1462907459.9981.0.camel@plaes.org>
Message-ID: <20160511221541.GG3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10, Priit Laes wrote:
> On Mon, 2016-05-09 at 15:39 -0700, Stephen Boyd wrote:
> > On 05/09, Stephen Boyd wrote:
> > > 
> > > 
> > > Ok I applied this one to clk-next.
> > > 
> > And I squashed this in to silence the following checker warning.
> > 
> > drivers/clk/sunxi/clk-sun4i-display.c:110:33: warning: Variable
> > length array is used.
> > 
> > ---8<---
> > diff --git a/drivers/clk/sunxi/clk-sun4i-display.c
> > b/drivers/clk/sunxi/clk-sun4i-display.c
> > index f02e250e64ed..f8ff6c4a5633 100644
> > --- a/drivers/clk/sunxi/clk-sun4i-display.c
> > +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> > @@ -107,7 +107,7 @@ static int sun4i_a10_display_reset_xlate(struct
> > reset_controller_dev *rcdev,
> > ?static void __init sun4i_a10_display_init(struct device_node *node,
> > ?					??const struct
> > sun4i_a10_display_clk_data *data)
> > ?{
> > -	const char *parents[data->parents];
> > +	const char *parents[4];
> 
> This change breaks at least de_[bf]e clocks which have 3 clock parents.
> 

I just used the largest data->parents number, which was 4. How
does that break anything?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
