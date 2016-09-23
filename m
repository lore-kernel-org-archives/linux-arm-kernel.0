From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 23 Sep 2016 13:46:41 -0700
Subject: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
In-Reply-To: <663a8a97-f01f-ce10-b0c6-c1a5ca0f11d2@ti.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
 <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
 <20160923142634.zkaqxmiif22kws2e@atomide.com>
 <06e0406c-3ff0-a069-a48a-0b1b82872f98@oracle.com>
 <663a8a97-f01f-ce10-b0c6-c1a5ca0f11d2@ti.com>
Message-ID: <cf1fa665-be83-9049-5bc1-c10a02292bbf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 9/23/2016 12:05 PM, Peter Ujfalusi wrote:
> On 09/23/2016 06:24 PM, Santosh Shilimkar wrote:
>> On 9/23/2016 7:26 AM, Tony Lindgren wrote:
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160923 00:21]:
>>>> On 09/22/16 21:07, Tony Lindgren wrote:
>>
>> [...]
>>
>>>> On which linux-next version you are seeing this?
>>>
>>> This was with next-20160922. But testing it again this is just another
>>> regression caused by "softirq: fix tasklet_kill() and its users", so adding
>>> Santosh to Cc.
>>>
>>> So no need to revert $subject patch.
>>>
>> So your driver also looks like fiddling with tasklet core structures if
>> you got impacted because of the core change.
>
> How is that? None of the drivers in the twl6040 stack uses tasklets
> explicitly. The core uses regmap_irq and the drivers use threaded irq when
> they need interrupt handling, but no tasklet, no fiddling with internals.
>
May be MFD core or some up dependency for this driver does that.
If not then you shouldn't be impacted because of the change.

Regards,
Santosh
