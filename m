From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Feb 2016 18:36:45 -0800
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <CAGhQ9VxPt7FmE4JN_-rBJMNpLpGoKVKocVFPWc3siV29Pk0_mQ@mail.gmail.com>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <1436651307-24098-2-git-send-email-manabian@gmail.com>
 <20150811204127.31346.16729@quantum>
 <CAGhQ9VwZaM_iWTkQYVTuTiyb6gCG2y6s8WFVySCHt7YHE1qbcA@mail.gmail.com>
 <20150818002604.31346.18322@quantum>
 <CAGhQ9VzOYbHsFZQxM8823OiWpGB6vLEwX8LfvjC=DnL1iqK_qQ@mail.gmail.com>
 <20160217005629.2278.90197@quark.deferred.io>
 <CAGhQ9VzB_WgB8b4_c3Z17W+K2MC7Fq7SD9zEvZUN_UJVGDZ3Wg@mail.gmail.com>
 <20160217202824.2278.25956@quark.deferred.io>
 <CAGhQ9VxPt7FmE4JN_-rBJMNpLpGoKVKocVFPWc3siV29Pk0_mQ@mail.gmail.com>
Message-ID: <20160219023645.GP4847@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17, Joachim Eastwood wrote:
> 
> For creg-clk it would probably work.
> 
> cgu would need to register most of clocks early since it needs to
> support whatever setup the bootloader throws at it. The only clocks
> that could be taken out is the base clocks (clk_onecell_data
> clk_base_data) except for one of them. But splitting this table would
> be a bad idea as hw clk numbers are used as indexes for easy look up.
> 
> Come to think of it; isn't splitting the clock table between a early
> init and platform driver going become a problem?
> At least the lookup in the driver or framework would become more complex(?)
> And won't you confuse the lookup?
> If the early driver register one clock table with
> of_clk_add_provider() and then sometime later the platform driver
> register another clock table, both using the same of_node. How is that
> suppose to work?

I believe that should work, although I haven't tested it. The
code looks until it finds a provider that matches the device node
and gives us a valid clk pointer. If we don't get a valid pointer
we keep looking for another provider until we exhaust all
providers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
