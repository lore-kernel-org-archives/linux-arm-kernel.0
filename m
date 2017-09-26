From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Sep 2017 15:20:27 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable CMA options
In-Reply-To: <158a7e84-dd66-e861-544d-172b2d3723ec@ti.com>
References: <20170920180132.4373-1-s-anna@ti.com>
 <758ebb8d-cdf5-4cdc-253b-b1eb8e2f7c61@ti.com>
 <52fd708b-8497-8d5d-262b-f78ecf068d87@ti.com>
 <e6232a0b-c2c2-2d20-758e-8b38e65091d7@ti.com>
 <158a7e84-dd66-e861-544d-172b2d3723ec@ti.com>
Message-ID: <cf0b63e6-613a-221c-ff40-ef3e333e5423@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 September 2017 09:54 PM, Suman Anna wrote:
> Hi Sekhar,
> 
>>
>> On Thursday 21 September 2017 08:41 PM, Suman Anna wrote:
>>> On 09/21/2017 09:43 AM, Sekhar Nori wrote:
>>>> On Wednesday 20 September 2017 11:31 PM, Suman Anna wrote:
>>>>> Enable the CMA and DMA_CMA Kconfig options by default for
>>>>> Davinci platforms. Davinci remoteproc driver is one of the
>>>>> modules that depends on these options, and this allows the
>>>>> driver to be made visible for selection with menuconfig.
>>>>>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> ---
>>>>> Hi Sekhar,
>>>>>
>>>>> Here's the patch that enables CMA as per your request. Patch based
>>>>> on your v4.15/defconfig branch.
>>>>
>>>> Applied! I guess you will be sending another patch enabling the
>>>> remoteproc driver itself?
>>>
>>> Thanks. Well, one always needs a firmware image in their filesystem
>>> without which enabling the driver is meaningless (it would fail). So was
>>> not planning to enable it by default.
>>
>> But the errors will show up only on DA850 LCDK where we have enabled the
>> DSP by default in DT because its an important usecase there. I think it
>> is important for users to see those errors.
>> (besides the usual benefits of having the module enabled to catch build
>> and runtime issues easily).
> 
> Yeah, DSP node is enabled only for DA850 LCDK among the DT-supported
> boards, but I believe there are boards still using legacy boot, and it
> shows up on those platforms as well. FYI, we do not have any rpmsg

Thats right. Even there, my thinking is if a board is registering a
platform device, its because it wants to use it. And so the driver
should be enabled.

> drivers other than the kernel sample to make real usage of a booted
> remoteproc. Anycase, if you still prefer this to be added, I don't mind.

I think its better to enable the driver too. Please submit a patch. Thanks!

Regards,
Sekhar
