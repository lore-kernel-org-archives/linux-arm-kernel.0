From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 15 Jul 2011 15:14:28 +1000
Subject: [PATCH 6/6] clk: Add initial WM831x clock driver
In-Reply-To: <20110715050503.GL32716@opensource.wolfsonmicro.com>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1310352837-4277-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110715025339.GO2927@ponder.secretlab.ca>
	<20110715050503.GL32716@opensource.wolfsonmicro.com>
Message-ID: <4E1FCCB4.4080205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/11 15:05, Mark Brown wrote:
> On Thu, Jul 14, 2011 at 08:53:39PM -0600, Grant Likely wrote:
>> On Mon, Jul 11, 2011 at 11:53:57AM +0900, Mark Brown wrote:
>>> +	if (clkdata->xtal_ena)
>>> +		return 0;
>>> +	else
>>> +		return -EPERM;
>>> +}
>> Nit: return clkdata->xtal_ena ? 0 : -EPERM;
>> Just makes for more concise code.
> I have an extremely strong dislike of the ternery operator, I find it
> does nothing for legibility.
>
I prefer this:

     if (!clkdata->xtal_ena)
         return -EPERM;

     return 0;
}

Which makes the error check clear and makes the success case visible 
right at the bottom of the function.

~Ryan
