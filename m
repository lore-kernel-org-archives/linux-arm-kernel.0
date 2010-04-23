From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 23 Apr 2010 17:20:08 +0400
Subject: [PATCH 2/2] i.MX35: remove get_3_3_div helper function
In-Reply-To: <20100423123827.GC7882@pengutronix.de>
References: <1272008426-14435-1-git-send-email-s.hauer@pengutronix.de>
	<1272008426-14435-3-git-send-email-s.hauer@pengutronix.de>
	<4BD172A3.8050500@ru.mvista.com>
	<20100423123827.GC7882@pengutronix.de>
Message-ID: <4BD19E88.3010907@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Sascha Hauer wrote:

>>>  static unsigned long get_rate_uart(struct clk *clk)
>>>  {
>>>  	unsigned long pdr3 = __raw_readl(CCM_BASE + CCM_PDR3);
>>>  	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
>>> -	unsigned long div = get_3_3_div(pdr4 >> 10);
>>> +	unsigned long div = ((pdr4 >> 10) & 0x3f) + 1;
>>>   	if (pdr3 & (1 << 14))
>>>  		return get_rate_arm() / div;
>>> @@ -218,7 +213,7 @@ static unsigned long get_rate_sdhc(struct clk *clk)
>>>  		break;
>>>  	}
>>>  -	return rate / get_3_3_div(div);
>>> +	return rate / (div + 1);
>>>   
>>>       
>>   You're adding 1 to divisor twice here...
>>     
>
> Look again, these hunks are in two different functions.
>   

   Indeed -- sorry.

> Sascha

WBR, Sergei
