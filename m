From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 20 Aug 2013 18:54:15 -0400
Subject: [PATCH 2/8] clk: keystone: Add gate control clock driver
In-Reply-To: <20130820224128.4443.78729@quantum>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-3-git-send-email-santosh.shilimkar@ti.com>
 <20130813161314.GR27165@e106331-lin.cambridge.arm.com>
 <520A60A2.2030104@ti.com>
 <20130813165344.GU27165@e106331-lin.cambridge.arm.com>
 <20130819204353.4443.48466@quantum> <5213756A.5090903@ti.com>
 <20130820213045.4443.89971@quantum> <5213E5EC.8070208@ti.com>
 <20130820224128.4443.78729@quantum>
Message-ID: <5213F397.6020708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 August 2013 06:41 PM, Mike Turquette wrote:
> Quoting Santosh Shilimkar (2013-08-20 14:55:56)
>> On Tuesday 20 August 2013 05:30 PM, Mike Turquette wrote:

[...]

>>>> They are bit different w.r.t OMAP. LPSC itself is the clock control of the
>>>> IP. The LPSC number in the bindings is actually the specific number which
>>>> is used to reach to the address space of the clock control. One can view
>>>> that one as clock control register index.
>>>
>>> Thanks for the information. I have a further question about then: are
>>> the LPSC clocks really module clocks that belong to the IP that they are
>>> gating?
>>>
>> LPSC controls the clock enable/disable to the IP/module so answer is yes.
>> In certain cases LPSC controls clock to more than one IP as well.
>>
>>> If so then they could be defined within the node defining their parent
>>> IP. That might be enough to get rid of the LPSC index value. Again I
>>> might be over-engineering it. Just trying to get an understanding.
>>>
>> Am not sure I follow you here on not having the LPSC index. Sorry. 
> 
> How are the 'reg' property and the 'lpsc' property related? Does the
> lpsc property modify the register address used to access the clock
> control bits?
> 
Yes it does. Currently all nodes use fix address and then lpsc is
used as an index. But I think we can do better by just using the
right(offset) address in the reg property. Will have a look at it
and see what I can do here.

Thanks for asking this questions Mike 

regards,
Santosh
