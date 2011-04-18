From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Apr 2011 11:46:57 -0700
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <20110418184138.GE25671@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
	<20110418131527.GF31131@pengutronix.de>
	<20110418133353.GL14770@pengutronix.de>
	<4DAC7AE9.9030106@codeaurora.org>
	<20110418183421.GD25671@n2100.arm.linux.org.uk>
	<20110418184138.GE25671@n2100.arm.linux.org.uk>
Message-ID: <4DAC8721.7090106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2011 11:41 AM, Russell King - ARM Linux wrote:
> On Mon, Apr 18, 2011 at 07:34:21PM +0100, Russell King - ARM Linux wrote:
>> Oops, clk_get_sys() and clk_find() really should be fixed for this.  I'll
>> sort a patch for it.
> And here it is:
>
> 8<----
> Subject: [PATCH] Fix clkdev return value for NULL clk case
>
> clkdev may incorrectly cause a clkdev entry with a NULL clk to return
> -ENOENT.  This is not the intention of this code; -ENOENT should only
> be returned if the clock entry can not be found in the table.  Fix this.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks. Feel free to include a:

Reported-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
