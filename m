From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 16 Jun 2014 10:19:42 +0100
Subject: [PATCH] ARM: STi: DT: Properly define sti-ethclk & stmmaceth for
 stih415/6
In-Reply-To: <20140616090146.GI14323@lee--X1>
References: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
 <20140616090146.GI14323@lee--X1>
Message-ID: <20140616091942.GA27978@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> >  		ethernet1: dwmac at fef08000 {
> > @@ -189,11 +189,11 @@
> >  			st,syscon		= <&syscfg_sbc>;
> >  
> >  			resets			= <&softreset STIH415_ETH1_SOFTRESET>;
> > -			reset-names		= "stmmaceth";
> > +			reset-names		= "stmmaceth", "sti-ethclk";
> >  			pinctrl-names 	= "default";
> >  			pinctrl-0	= <&pinctrl_mii1>;
> >  			clock-names	= "stmmaceth";
> > -			clocks		= <&clk_s_a0_ls CLK_ETH1_PHY>;
> > +			clocks		= <&clk_s_a0_ls CLK_ICN_REG>, <&clk_s_a0_ls CLK_ETH1_PHY>;
> 
> This looks wrong to me.  You appear to have changed the reset-names
> instead of the clock-names here.

Whoops, your right, I'll send a V2 shortly.

Pete.
