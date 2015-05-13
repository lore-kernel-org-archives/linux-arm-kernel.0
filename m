From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 May 2015 11:09:36 -0700
Subject: [PATCHv2] ARM: socfpga: dts: Add a clock node for sdmmc CIU
In-Reply-To: <5553671E.3070301@opensource.altera.com>
References: <1429027519-22209-1-git-send-email-dinguyen@opensource.altera.com>
 <20150513075438.GE15988@codeaurora.org>
 <5553671E.3070301@opensource.altera.com>
Message-ID: <20150513180936.GG15988@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13, Dinh Nguyen wrote:
> 
> 
> On 5/13/15 2:54 AM, Stephen Boyd wrote:
> > On 04/14, dinguyen at opensource.altera.com wrote:
> >> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> >>
> >> The CIU(Card Interface Unit) get its clock from the sdmmc_clk_divided clock
> >> which is used to clock the card. The sdmmc_clk_divided clock is the sdmmc_clk
> >> passed through a fixed divider of 4. This patch adds the sdmmc_clk_divided
> >> node and makes the sdmmc_clk it's parent.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> >> ---
> > 
> > Is this a fix of some sort? I'm confused why this was sent to the
> > clk maintainers when it seems to be more appropriate to go
> > through the arm-soc tree.
> > 
> 
> Ok, sorry about that. I thought since it was clock nodes, it would
> appropriate to CC clk maintainers.

Sure, Cc is fine, but I believe the mail was sent "To" us so that
led to my confusion.

> 
> BTW, can I take patches from drivers/clk/socfpga/* through the arm-soc
> tree or would that go through you guys?
> 

Unless there's some sort of complicated dependency between the
clk tree and the arm-soc tree I'd prefer any patches against
drivers/clk/* go through the clk tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
