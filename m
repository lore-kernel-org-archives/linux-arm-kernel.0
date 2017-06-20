From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Jun 2017 13:41:52 -0700
Subject: [PATCH 9/9] clk: imx: add imx7ulp clk driver
In-Reply-To: <20170620094256.GF6805@b29396-OptiPlex-7040>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-10-git-send-email-aisheng.dong@nxp.com>
 <20170620020119.GQ4493@codeaurora.org>
 <20170620094256.GF6805@b29396-OptiPlex-7040>
Message-ID: <20170620204152.GS4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20, Dong Aisheng wrote:
> On Mon, Jun 19, 2017 at 07:01:19PM -0700, Stephen Boyd wrote:
> > 
> > Any reason why it can't be a platform driver? If not, please add
> > some comment explaining why.
> > 
> 
> Timer is using it at early stage. GIC seems not although standard
> binding claim possible clock requirement.
> Others still not sure.
> 
> What your suggestion?
> Convert timer to platform driver and make clock as platform driver as well?
> 

The timer can't be a platform driver because it would be too
late. The clock driver could register whatever clks are required
for the timer/GIC in a CLK_OF_DECLARE_DRIVER hook, and then leave
the rest to a platform driver. This way we get some of the device
driver framework in this code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
