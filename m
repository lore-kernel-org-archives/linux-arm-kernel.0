From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Apr 2018 11:56:55 +0530
Subject: [PATCH v2] ARM: davinci: dm644x: remove unnecessary
 postcore_initcall()
In-Reply-To: <bf45cf15-95ea-632b-f03c-cca4ef1d933e@lechnology.com>
References: <20180406123820.21679-1-nsekhar@ti.com>
 <bf45cf15-95ea-632b-f03c-cca4ef1d933e@lechnology.com>
Message-ID: <7eef1004-4ae3-95d8-ac78-b9a0ef74e4d0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 April 2018 01:41 AM, David Lechner wrote:
> On 04/06/2018 07:38 AM, Sekhar Nori wrote:
>> dm644x_init_devices() is unnecessarily implemented as a
>> postcore_initcall().
>>
>> This does not cause any issues now, but creates issues when
>> converting to common clock framework where clocks themselves
>> become platform devices and are initialized later. Because of
>> this, device clock acquisition and runtime PM on that device
>> fails.
>>
>> Move the call to .init_machine() callback along with rest of
>> platform device's registration.
>>
>> While at it, convert it to return void since return value is
>> ignored by caller anyway.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

Applied to v4.18/soc

Thanks,
Sekhar
