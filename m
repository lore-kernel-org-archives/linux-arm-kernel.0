From: lyz@rock-chips.com (Yunzhi Li)
Date: Thu, 11 Dec 2014 14:52:22 +0800
Subject: [PATCH v5 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <1418279847.18092.32.camel@perches.com>
References: <1418208371-18851-1-git-send-email-lyz@rock-chips.com>	
 <1418208371-18851-2-git-send-email-lyz@rock-chips.com>	
 <5489338C.1030109@ti.com> <1418278322.18092.30.camel@perches.com>	
 <54893963.7060304@ti.com> <1418279847.18092.32.camel@perches.com>
Message-ID: <54893F26.5050304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014/12/11 14:37, Joe Perches wrote:
> On Thu, 2014-12-11 at 11:57 +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Thursday 11 December 2014 11:42 AM, Joe Perches wrote:
>>> On Thu, 2014-12-11 at 11:32 +0530, Kishon Vijay Abraham I wrote:
>>>> On Wednesday 10 December 2014 04:16 PM, Yunzhi Li wrote:
>>>>> diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
>>> []
>>>>> +/*
>>>>> + * The higher 16-bit of this register is used for write protection
>>>>> + * only if BIT(13 + 16) set to 1 the BIT(13) can be written.
>>>>> + */
>>>>> +#define SIDDQ_MSK		BIT(13 + 16)
>>> huh?
>>>
>>> This #define looks _very_ odd.
>>>
>>> Is this supposed to be a single bit 29 or
>>> some range?
>>  From what I understood, the most significant 16 bits are write locks to the
>> least significant 16 bits.
>>
>> So If I have to write something on bit 0, I have to set bit 16.
>> If I have to write something on bit 1, I have to set bit 17.
>> If I have to write something on bit 2, I have to set bit 18.
>> and so on.
> To me it'd look better to use another << rather than a plus
Like (BIT(13) << 16)? It looks strange, or could I just use ((1 << 13) 
<< 16) to describe this bit ?

---
Yunzhi Li @ rockchip
