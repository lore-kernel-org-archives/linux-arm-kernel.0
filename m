From: abailon@baylibre.com (Alexandre Bailon)
Date: Thu, 1 Dec 2016 18:04:09 +0100
Subject: [PATCH v2] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <2968058.oO7jkWYDV8@wuerfel>
References: <1480438111-11801-1-git-send-email-abailon@baylibre.com>
 <ed09fc5e-395a-5e72-4928-5e85cdc7f2c3@ti.com> <2968058.oO7jkWYDV8@wuerfel>
Message-ID: <c669eae7-b7be-47d8-777a-481e3ff64d3e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2016 03:59 PM, Arnd Bergmann wrote:
> On Thursday, December 1, 2016 7:47:12 PM CET Sekhar Nori wrote:
>>
>>> @@ -287,9 +281,15 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
>>>       struct clk *parent;
>>>       int ret = 0;
>>>  
>>> +     usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
>>> +     if (IS_ERR(usb20_clk))
>>> +             return PTR_ERR(parent);
>>
>> Typo here. Should be PTR_ERR(usb20_clk)
> 
> I found that doing
> 
> 		err = PTR_ERR_OR_ZERO(usb20_clk);
> 		if (err)
> 			return err;
> 
> is less error-prone and leads to better object code.
> 
> 	Arnd
> 
I didn't know that one.
I will use it.

Thanks,
Alexandre
