From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Apr 2011 22:41:59 -0700
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <1303173160.2801.13.camel@pororo>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>	
	<4DACBDC6.2000500@codeaurora.org> <1303173160.2801.13.camel@pororo>
Message-ID: <4DAD20A7.6040609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/2011 5:32 PM, Jeremy Kerr wrote:
> Hi Stephen,
>
>>> +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
>> Can you make this a static inline function with actual types? We get
>> slightly more type safety that way.
> Do we? The container_of macro requires that that it's first argument is
> the same type as type->member, and returns a (type), so I don't see how
> we're going to miss typing errors here.

Ah yes you're right. Should have looked further. I still like static
inline functions for these things but I don't see any reason why one is
better over the other.

Thanks,
Stephen

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
