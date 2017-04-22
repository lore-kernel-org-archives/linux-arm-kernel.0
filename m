From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Apr 2017 20:04:19 -0700
Subject: [RFC PATCH 0/3] clk: introduce clk_bulk_get accessories
In-Reply-To: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170422030419.GV7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12, Dong Aisheng wrote:
> 
> Together with the err path handling for each clocks, it does make
> things a bit ugly.
> 
> Since we already have regulator_bulk_get accessories, i thought we
> probably could introduce clk_bulk_get as well to handle such case to
> ease the driver owners' life. 
> 
> Besides IMX cpufreq driver, there is also some similar cases
> in kernel which could befinit from this api as well.
> e.g.
> drivers/cpufreq/tegra124-cpufreq.c
> drivers/cpufreq/s3c2412-cpufreq.c
> sound/soc/samsung/smdk_spdif.c
> arch/arm/mach-omap1/serial.c
> ...
> 
> And actually, if we handle clocks more than 3, then it might be
> worthy to try, which there is quite many manay in kernel and
> that probably could save a lot codes.
> 
> This is a RFC patch intending to bring up the idea to discuss.
> 

Idea seems fine to me. Please also add Russell King, as we need
an ack from him on the clk.h API changes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
