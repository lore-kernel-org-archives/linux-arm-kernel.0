From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Oct 2016 16:37:50 -0700
Subject: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
In-Reply-To: <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
Message-ID: <20161028233750.GQ16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Tero Kristo wrote:
> Eventually that should happen. However, we have plenty of legacy
> code still in place which depend on clk_get functionality within
> kernel. The major contributing factor is the hwmod codebase, for
> which we have plans to:
> 
> - get this clock driver merged
> - implement a new interconnect driver for OMAP family SoCs
> - interconnect driver will use DT handles for fetching clocks,
> rather than clock aliases
> - reset handling will be implemented as part of the interconnect
> driver somehow (no prototype / clear plans for that as of yet)
> - all the hwmod stuff can be dropped
> 
> The clock alias handling is still needed as a transition phase until
> all the above is done, then we can start dropping them. Basically
> anything that is using omap_hwmod depends on the clock aliases right
> now.

Ok, sounds good. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
