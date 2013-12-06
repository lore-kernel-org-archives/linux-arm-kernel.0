From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 6 Dec 2013 11:51:02 +0530
Subject: [PATCH 1/4] pinctrl: tegra: Add devicetree binding document for
 Tegra124
In-Reply-To: <52A10973.5000101@wwwdotorg.org>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
 <1386241070-4350-2-git-send-email-ldewangan@nvidia.com>
 <52A10973.5000101@wwwdotorg.org>
Message-ID: <52A16CCE.7030304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 04:47 AM, Stephen Warren wrote:
> On 12/05/2013 03:57 AM, Laxman Dewangan wrote:
>> This device tree binding document describes the Tegra124 pincontrol
>> DT bindings. This document lists all valid properties, names, mux
>> options of Tegra124 pins.
> Is this a repost of what Ashwini sent a few weeks back, or V2? If V2,
> it'd be useful to know what changed...

I am not aware that Ashwini already sent  back. I did not get chance to 
talk to her on this. I was thinking that it is still in internal review.

Anyhow, I compare the downstream to your linux-next-common and found 
some diff. Something fixed in your tree which need downstream and 
something fixed in downstream which need to upstream. :)

One diff is
Mux enums are:

TEGRA_MUX_SATA,
TEGRA_MUX_CCLA,
TEGRA_MUX_PE0,
TEGRA_MUX_PE,
TEGRA_MUX_PE1,
TEGRA_MUX_DP,
TEGRA_MUX_RTCK,
TEGRA_MUX_SYS,
TEGRA_MUX_CLK,
TEGRA_MUX_TMDS,
};


Functions definitions are:

FUNCTION(sata),
FUNCTION(ccla),
FUNCTION(rtck),
FUNCTION(pe0),
FUNCTION(pe),
FUNCTION(pe1),
FUNCTION(dp),



I think I will post the patch to fix this issue.
