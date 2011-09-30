From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 30 Sep 2011 12:08:58 -0500
Subject: [PATCH 2/2] ARM: Switch to using CLKDEV_INIT macro for creating
	clk_lookup instance
In-Reply-To: <4E85B779.7030402@gmail.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-3-git-send-email-padma.v@samsung.com>
	<4E85B779.7030402@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DC56761@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 30, 2011 5:35 AM, Ryan Mallon wrote:
> On 30/09/11 21:11, Padmavathi Venna wrote:
>> Replace platform specific macros that creates struct clk_lookup
>> instance with the new common CLKDEV_INIT macro
>>
>> Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---

[...]

>>  static struct clk_lookup cdce_clks[] = {
>> -	CLK(NULL, "xin", &cdce_clk_in),
>> -	CLK(NULL, NULL, NULL),
>> +	CLKDEV_INIT(NULL, "xin", cdce_clk_in)
>> +	{.dev_id = NULL, .con_id = NULL, .clk = NULL,},
>
> Why not CLKDEV_INIT(NULL, NULL, NULL)? Or create another macro
> CLKDEV_NULL (or similar) for the last entry in the list rather than
> duplicating this everywhere.

The CLKDEV_INIT macro does this with the third parameter:

	.clk = &c,

I'm not sure &NULL is valid.

Is the sentinel entry actually needed?  ep93xx does not have one.

Regards,
Hartley
