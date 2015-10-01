From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 10:49:16 -0700
Subject: [PATCH 04/16] clk: at91: make use of syscon to share PMC
 registers in several drivers
In-Reply-To: <1443629469-15086-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1443629469-15086-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20151001174916.GD19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The PMC block is providing several functionnalities:
>  - system clk management
>  - cpuidle
>  - platform suspend
> 
> Replace the void __iomem *regs field by a regmap (retrieved using syscon)
> so that we can later share the regmap across several drivers without
> exporting a new specific API or a global void __iomem * variable.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
