From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jul 2013 09:36:02 -0700
Subject: [PATCH v1 03/14] clk: Add of_clk_match() for device drivers
In-Reply-To: <52875092.tEWeSbEJZC@flatron>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-4-git-send-email-sboyd@codeaurora.org>
 <52875092.tEWeSbEJZC@flatron>
Message-ID: <20130725163602.GB29694@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25, Tomasz Figa wrote:
> Hi Stephen,
> 
> On Wednesday 24 of July 2013 17:43:31 Stephen Boyd wrote:
> > In similar fashion as of_regulator_match() add an of_clk_match()
> > function that finds an initializes clock init_data structs from
> > devicetree. Drivers should use this API to find clocks that their
> > device is providing and then iterate over their match table
> > registering the clocks with the init data parsed.
> 
> I think all you need here is declaring all your clock drivers using 
> CLK_OF_DECLARE() macro. Then they will be automatically probed by 
> of_clk_init(). See last lines of drivers/clk/clk-fixed-rate.c for an 
> example.
> 

CLK_OF_DECLARE() will not work because it doesn't give the
caller a struct device. I want that struct device to use managed
allocations and clk registrations.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
