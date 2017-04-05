From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Apr 2017 14:52:18 -0700
Subject: [PATCH v2 1/2] clk: stm32f4: fix: exclude values 0 and 1 for PLLQ
In-Reply-To: <1489652201-19889-2-git-send-email-gabriel.fernandez@st.com>
References: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
 <1489652201-19889-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170405215218.GF7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> 0000: PLLQ = 0, wrong configuration
> 0001: PLLQ = 1, wrong configuration
> ...
> 0010: PLLQ = 2
> 0011: PLLQ = 3
> 0100: PLLQ = 4
> ...
> 1111: PLLQ = 1
> 
> Use divider table to exclude 0 and 1 values.
> 
> Fixes: 83135ad3c517 ("clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469 boards")
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
