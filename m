From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 09:43:50 -0700
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix wrong return value in
 get_parent
In-Reply-To: <20180713102726.1950-1-gregory.clement@bootlin.com>
References: <20180713102726.1950-1-gregory.clement@bootlin.com>
Message-ID: <153253703023.48062.216865546147364380@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-07-13 03:27:26)
> The return value of the get_parent operation is a u8, whereas a -EINVAL
> was returned. This wrong value was return if the value was bigger that
> the number of parent but this case was already handled by the core.
> 
> So we can just remove this chunk of code to fix the issue.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 9818a7a4fd10 ("clk: mvebu: armada-37xx-periph: prepare cpu clk to
> be used with DVFS")
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next

This is actually a good point I've never considered. We should go fix
all the drivers that return a negative value to return a number that's
greater than the number of clks that are the parents and then we can
still get 'errors' from this clk_op.
