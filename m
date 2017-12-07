From: davem@davemloft.net (David Miller)
Date: Thu, 07 Dec 2017 13:52:07 -0500 (EST)
Subject: [PATCH] net: ethernet: arc: fix error handling in
 emac_rockchip_probe
In-Reply-To: <20171206230738.2560-1-branislav@radocaj.org>
References: <20171206230738.2560-1-branislav@radocaj.org>
Message-ID: <20171207.135207.212566260948460919.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Branislav Radocaj <branislav@radocaj.org>
Date: Thu,  7 Dec 2017 00:07:38 +0100

> If clk_set_rate() fails, we should disable clk before return.
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Branislav Radocaj <branislav@radocaj.org>

Ok, but this probe routine is very inconsistent in how it handles
clock rate setting failures now.

Above your changes, if the RGMII clk can't have it's rate set, we
just continue.
