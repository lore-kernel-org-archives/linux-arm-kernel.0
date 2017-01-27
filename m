From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:27:50 -0800
Subject: [PATCH v2] clk: samsung: mark s3c...._clk_sleep_init() as __init
In-Reply-To: <1485380545-24815-1-git-send-email-martin@kaiser.cx>
References: <1485293599-23581-1-git-send-email-martin@kaiser.cx>
 <1485380545-24815-1-git-send-email-martin@kaiser.cx>
Message-ID: <20170127002750.GC8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25, martin at kaiser.cx wrote:
> From: Martin Kaiser <martin@kaiser.cx>
> 
> These functions are referencing s3c...._clk_regs[], which are marked as
> __initdata. When compiling with CONFIG_DEBUG_SECTION_MISMATCH=y, this
> produces warnings like
> 
> WARNING: vmlinux.o(.text+0x198350):
> Section mismatch in reference from the function s3c2410_clk_sleep_init()
> to the (unknown reference) .init.data:(unknown)
> 
> Mark the s3c...._clk_sleep_init() functions as __init in
> order to fix this.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Fixes tag?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
