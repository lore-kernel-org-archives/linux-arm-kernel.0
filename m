From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Sep 2016 14:44:48 -0700
Subject: [PATCH v3 1/3] clk: mvebu: fix setting unwanted flags in CP110
 gate clock
In-Reply-To: <1474448759-24482-2-git-send-email-mw@semihalf.com>
References: <1474448759-24482-1-git-send-email-mw@semihalf.com>
 <1474448759-24482-2-git-send-email-mw@semihalf.com>
Message-ID: <20160923214448.GD21232@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21, Marcin Wojtas wrote:
> Armada CP110 system controller comprises its own routine responsble
> for registering gate clocks. Among others 'flags' field in
> struct clk_init_data was not set, using a random values, which
> may cause an unpredicted behavior.
> 
> This patch fixes the problem by resetting all fields of clk_init_data
> before assigning values for all gated clocks of Armada 7k/8k SoCs family.
> 
> Fixes: d3da3eaef7f4 ("clk: mvebu: new driver for Armada CP110 system ...")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> CC: <stable@vger.kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
