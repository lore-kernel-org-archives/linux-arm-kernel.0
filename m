From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 14:57:11 -0800
Subject: [PATCH v1 1/4] clk: iproc: Allow iproc pll to runtime calculate
 vco parameters
In-Reply-To: <1502737241-2040-2-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
 <1502737241-2040-2-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <20171228225711.GT7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14, Lori Hikichi wrote:
> Add the ability for the iproc pll to calculate the pll parameters at
> runtime instead of only using predefined tables. This ability allows
> the clock users to select from the full range of vco frequencies.
> The old method of table based programming is retained so that existing
> users will retain expected behavior. The flag IPROC_CLK_PLL_CALC_PARAM
> will need to be set to enable the new runtime calculation method.
> Currently, this is only being enabled for the audio pll.
> 
> This feature also revealed a problem with the driver using the
> round_rate api.  The round_rate api does not allow for frequencies larger
> than 2^31 to be returned.  Those large frequencies are interpreted as an
> error code. Therefore, we are moving to the determine_rate api which
> solves this problem.
> 
> Signed-off-by: Simran Rai <ssimran@broadcom.com>
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
