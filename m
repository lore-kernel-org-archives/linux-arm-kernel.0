From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:12:00 -0700
Subject: [PATCH] clk: mvebu: cp110: Fix clock tree representation
In-Reply-To: <20180228140751.10819-1-gregory.clement@bootlin.com>
References: <20180228140751.10819-1-gregory.clement@bootlin.com>
Message-ID: <152149032034.242365.10971731653439256704@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-02-28 06:07:51)
> Thanks to new documentation, we have a better view of the clock tree.
> There were few mistakes in the first version of this driver, the main one
> being the parental link between the clocks. Actually the tree is more
> flat that we though. Most of the IP blocks require two clocks: one for
> the IP itself and one for accessing the registers, and unlike what we
> wrote there is no link between these two clocks.
> 
> The other mistakes were about the name of the clocks: the root clock is
> not the Audio PLL but the PLL0, and what we called the EIP clock is named
> the x2 Core clock and is used by other IP block than the EIP ones.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next
