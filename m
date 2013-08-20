From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 20 Aug 2013 11:43:43 +0200
Subject: [PATCH 0/3] refactor some ldb related clocks
In-Reply-To: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1376991823.4000.22.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 20.08.2013, 16:38 +0800 schrieb Liu Ying:
> The ldb_di[0/1]_ipu_div clock dividers in the CSCMR2 register
> of i.MX53, i.MX6Q and i.MX6DL SoCs can be configured to a 1/3.5
> drivider or a 1/7 divider. The common clock framework cannot
> deal with the two dividers directly even with the divider table
> which only supports integral dividers. So, the idea is to take
> the 1/3.5 and 1/7 dividers as separate fixed factor dividers and
> introduce a new multiplexer clock to be derived from the them.
> Then, the ldb display clock trees can be setup correctly.
> This series contains the necessary clock driver changes, dts code
> changes and imx-drm/ldb driver changes to fullfill the task.

I don't see how this improves the situation. Does this solve any real
problem?

While I admit to having introduced the combination of 1/3.5 fixed
divider and configurable 1/1,1/2 divder clocks to describe this
fractional divider for the reasons you state, I think the correct
solution would be to improve the table divider to support fractional
values and get rid of the virtual ldb_di<n>_div_3_5 clocks, not
introduce more virtual clocks.

regards
Philipp
