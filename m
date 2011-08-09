From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 9 Aug 2011 17:16:43 -0500
Subject: [PATCH] ep93xx: clock.c: fix all checkpatch.pl issues
In-Reply-To: <4E41AAE1.7010008@gmail.com>
References: <201108091411.32479.hartleys@visionengravers.com>
	<4E41AAE1.7010008@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3883894B0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 09, 2011 2:47 PM, Ryan Mallon wrote:
> On 10/08/11 07:11, H Hartley Sweeten wrote:
>> This fixes all the checkpatch.pl errors and warnings found in this file.

[snip]

>> @@ -358,7 +360,7 @@ static int calc_clk_div(struct clk *clk, unsigned long rate,
>>  	int i, found = 0, __div = 0, __pdiv = 0;
>>  
>>  	/* Don't exceed the maximum rate */
>> -	max_rate = max3(clk_pll1.rate / 4, clk_pll2.rate / 4, clk_xtali.rate / 4);
>> +	max_rate = max3(clk_pll1.rate/4, clk_pll2.rate/4, clk_xtali.rate/4);
>
> Don't delete the spaces around the operators. Again, this line is only
> just over 80 characters. I think its okay as is. If you must fix it,
> break on one of the commas instead.

Ryan,

How about fixing the one above like this:

-	max_rate = max3(clk_pll1.rate / 4, clk_pll2.rate / 4, clk_xtali.rate / 4);
+	max_rate = max3(clk_pll1.rate, clk_pll2.rate, clk_xtali.rate);
+	max_rate /= 4;

Regards,
Hartley
