From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Oct 2014 17:20:56 -0700
Subject: [PATCH v2 4/4] clk: Use ww_mutexes for clk_prepare_{lock/unlock}
In-Reply-To: <20141010082434.GF29637@tbergstrom-lnx.Nvidia.com>
References: <1409792466-5092-1-git-send-email-sboyd@codeaurora.org>
 <1409792466-5092-5-git-send-email-sboyd@codeaurora.org>
 <20140928024131.19023.40641@quantum>
 <5429F555.9030108@codeaurora.org> <54348EC2.3040300@codeaurora.org>
 <20141009025923.4379.66113@quantum>
 <20141010082434.GF29637@tbergstrom-lnx.Nvidia.com>
Message-ID: <20141011002056.GJ5493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10, Peter De Schrijver wrote:
> > > drivers/clk/tegra/clk-pll.c:732:    unsigned long input_rate = 
> > > clk_get_rate(clk_get_parent(hw->clk));
> > > drivers/clk/tegra/clk-pll.c:1288:    unsigned long input_rate = 
> > > clk_get_rate(clk_get_parent(hw->clk));
> 
> This is not so easy to change unfortunately. I will have to think of a solution.
> 

Thanks. Does the input parent rate change at runtime or is it
fixed at boot? I'm hoping we can call _get_table_rate() once
before we register the clock or something.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
