From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 12:55:03 -0800
Subject: [PATCH 1/3] ARM: imx: clk-vf610: fix SAI clock tree
In-Reply-To: <1445141122-14183-1-git-send-email-stefan@agner.ch>
References: <1445141122-14183-1-git-send-email-stefan@agner.ch>
Message-ID: <20151130205503.GO11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17, Stefan Agner wrote:
> The Synchronous Audio Interface (SAI) instances are clocked by
> independent clocks: The bus clock and the audio clock (as shown in
> Figure 51-1 in the Vybrid Reference Manual). The clock gates in
> CCGR0/CCGR1 for SAI0 through SAI3 are bus clock gates, as access
> tests to the registers with/without gating those clocks have shown.
> The audio clock is gated by the SAIx_EN gates in CCM_CSCDR1,
> followed by a clock divider (SAIx_DIV). Currently, the parent of
> the bus clock gates has been assigned to SAIx_DIV, which is not
> involved in the bus clock path for the SAI instances (see chapter
> 9.10.12, SAI clocking in the Vybrid Reference Manual).
> 
> Fix this by define the parent clock of VF610_CLK_SAIx to be the bus
> clock.
> 
> If the driver needs the audio clock (when used in master mode), a
> fixed device tree is required which assign the audio clock properly
> to VF610_CLK_SAIx_DIV.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
