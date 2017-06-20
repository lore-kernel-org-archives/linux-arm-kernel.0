From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:01:25 -0700
Subject: [PATCH v6 1/3] clk: imx7d: create clocks behind rawnand clock gate
In-Reply-To: <8b9edf13938e3166081e72ba8fa4ac822035079c.1496961128.git-series.stefan@agner.ch>
References: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
 <8b9edf13938e3166081e72ba8fa4ac822035079c.1496961128.git-series.stefan@agner.ch>
Message-ID: <20170620010125.GI20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08, Stefan Agner wrote:
> The rawnand clock gate gates two clocks, NAND_USDHC_BUS_CLK_ROOT
> and NAND_CLK_ROOT. However, the gate has been in the chain of the
> latter only. This does not allow to use the NAND_USDHC_BUS_CLK_ROOT
> only, e.g. as required by APBH-Bridge-DMA.
> 
> Add new clocks which represent the clock after the gate, and use a
> shared clock gate to correctly model the hardware.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
