From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Mar 2015 15:36:58 -0700
Subject: [PATCH v2 01/11] clk: convert clock mux to accept regmap
In-Reply-To: <1425654784-27354-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654784-27354-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5500C38A.5070506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 07:12, Antoine Tenart wrote:
> Rework the clk_mux helpers to either use an iomem base address or a
> regmap.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>

Last time we tried this Mike was opposed. The union is a nice trick but
I'm not sure it will help much.

Perhaps you'd be interested in using the bits of the mux code that you
need by using this patch[1]? It makes it so you can use the mux and
associated flags as functions called from somewhere else. Building a
regmap mux on top of that should be fairly straightforward.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/284935.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
