From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 16:00:38 -0800
Subject: [PATCH] clk: imx51: uart4, uart5 gates only exist on imx50, imx53
In-Reply-To: <20171213115748.14106-1-p.zabel@pengutronix.de>
References: <20171213115748.14106-1-p.zabel@pengutronix.de>
Message-ID: <20171222000038.GI7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, Philipp Zabel wrote:
> i.MX51 only has 3 UARTs and no CCGR7 register. In place of the CCGR7
> register on i.MX50/i.MX53 that contains the ipg and per clock gates
> for UARTs 4 and 5, on i.MX51 there is the CMEOR register.
> 
> Without this patch, the code disabling the UART clocks would also clear
> the mod_en_ov_vpu bit in the CMEOR register, among others, which causes
> register accesses to the VPU to lock up the system.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
