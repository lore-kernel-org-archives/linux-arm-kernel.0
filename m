From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 15:06:32 -0800
Subject: [PATCH 1/2] clk: bcm: Support rate change propagation on bcm2835
 clocks
In-Reply-To: <1480626020-20031-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480626020-20031-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20161208230632.GS5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01, Boris Brezillon wrote:
> Some peripheral clocks, like the VEC (Video EnCoder) clock need to be set
> to a precise rate (in our case 108MHz). With the current implementation,
> where peripheral clocks are not allowed to forward rate change requests
> to their parents, it is impossible to match this requirement unless the
> bootloader has configured things correctly, or a specific rate has been
> assigned through the DT (with the assigned-clk-rates property).
> 
> Add a new field to struct bcm2835_clock_data to specify which parent
> clocks accept rate change propagation, and support set rate propagation
> in bcm2835_clock_determine_rate().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
