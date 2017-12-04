From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Dec 2017 02:25:18 +0000
Subject: [PATCH] clk: fix compile testing of scpi clk driver
In-Reply-To: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
References: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
Message-ID: <20171204022518.GD6870@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 07:58:23AM +0100, Heiner Kallweit wrote:
> We now have a hard dependency on ARM_SCPI_PROTOCOL and may end up with
> the following error:
> ERROR: "get_scpi_ops" [drivers/clk/clk-scpi.ko] undefined!
> Fix this by removing COMPILE_TEST from COMMON_CLK_SCPI dependencies.
> 
> Fixes: f7fee8be06a6 "firmware: arm_scpi: remove default for get_scpi_ops if not reachable"

This doesn't exist for all practical purposes. I pushed a branch to test
the commit as I was sure that it will cause build regression but I could
not figure to get that config. The Kbuild bot did find the issue.

You are introducing the bug in f7fee8be06a6 and trying to fix here, both of
them are wrong.

--
Regards,
Sudeep
