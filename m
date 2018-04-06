From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:47:33 -0700
Subject: [PATCH 2/2] clk: spear: fix WDT clock definition on SPEAr600
In-Reply-To: <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
 <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
Message-ID: <152304765337.94378.9011588137332248203@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Quentin Schulz (2018-04-06 00:50:45)
> There is no SPEAr600 device named "wdt". Instead, the description of the
> WDT (watchdog) was recently added to the Device Tree, and the device
> name is "fc880000.wdt", so we should associate the WDT fixed rate clock
> to this device name.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

Applied to clk-next

I take it there are other problems though, e.g. clcd. Why not use DT
lookups instead of clkdev ones?
