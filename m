From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 18:25:58 -0700
Subject: [PATCH v4 1/5] clk: unconditionally recurse into clk/mvebu/
In-Reply-To: <1459070777-18049-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160402012558.GC18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27, Thomas Petazzoni wrote:
> The drivers/clk/mvebu directory is only being built when
> CONFIG_PLAT_ORION=y. As we are going to support additional mvebu
> platforms in drivers/clk/mvebu, which don't have CONFIG_PLAT_ORION=y,
> we need to recurse into this directory regardless of the value of
> CONFIG_PLAT_ORION.
> 
> Since all files in drivers/clk/mvebu/ are already conditionally
> compiled depending on various Kconfig options, we can recurse
> unconditionally into drivers/clk/mvebu without any other change.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
