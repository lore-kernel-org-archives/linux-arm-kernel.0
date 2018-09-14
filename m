From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Fri, 14 Sep 2018 09:52:35 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <94a2aa4e-69ac-7042-92d9-1ada46d5fc33@roeck-us.net>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
 <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
 <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
 <ccbf7059-77fd-44e8-daee-516582814cb3@kaod.org>
 <94a2aa4e-69ac-7042-92d9-1ada46d5fc33@roeck-us.net>
Message-ID: <3e319dd0-17e6-679d-18fd-43ed59f7075d@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/14/2018 6:23 AM, Guenter Roeck wrote:
> On 09/13/2018 10:38 PM, C?dric Le Goater wrote:
>>>>> That seems to suggest that none of the status bits auto-clears, and 
>>>>> that
>>>>> the above code clearing intr_status should be removed entirely.
>>>>> Am I missing something ?
>>>>
>>>> You are right. I just pushed another version of the previous patch 
>>>> with this
>>>> new hunk :
>>>>
>>>> @@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
>>>> ?? {
>>>> ?????? bus->cmd &= ~0xFFFF;
>>>> ?????? bus->cmd |= value & 0xFFFF;
>>>> -??? bus->intr_status = 0;
>>>> ?? ????? if (bus->cmd & I2CD_M_START_CMD) {
>>>> ?????????? uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>>>>
>>>>
>>>> The QEMU palmetto and witherspoon machines seem to behave fine. Can 
>>>> you give
>>>> it a try ?
>>>>
>>>
>>> Works fine for me for all affected qemu platforms.
>>>
>>> How do you want to proceed with the qemu patches ? I attached my patches
>>> for reference. Maybe you can add them to your tree if they are ok and 
>>> submit
>>> the entire series together to the qemu mailing list ?
>>
>> yes. They are pushed in my aspeed-3.1 branch. I will send the series
>> on the list.
>>
> 
> Excellent. Thanks a lot!
> 
> Guenter
> 

Awesome! Many thanks to Guenter, C?dric and Joel. I really appreciate
it.

Jae
