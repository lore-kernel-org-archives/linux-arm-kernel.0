From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:25:30 -0700
Subject: [PATCH V1 0/9] add clock driver for Spreadtrum platforms
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170620012530.GG4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Chunyan Zhang wrote:
> In the last cycle, the patches support Whale2 sc9860 mobile chip have been
> merged. This patchset adds clock driver which is used on almost all
> Spreadtrum SoCs.
> 
> This is a rewrite of Spreadtrum's original clock driver[1] according to the
> comments[2] from Stephen Boyd.
> 
> This series also adds Spreadtrum clock binding documentation and devicetree
> data.
> 
> Any comments would be greatly appreciated.

Overall it seems to copy quite a bit of code from sunxi-ng, which
is OK, but if that's just copy/paste + replace some names then
perhaps we should consolidate the two implementations into one
that both SoCs can use.

Also, is there any reason why we can't use a platform device
driver for this instead of the DT probing mechanism? That is more
preferred method of probing clk controllers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
