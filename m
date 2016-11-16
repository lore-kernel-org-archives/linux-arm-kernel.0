From: anurupvasu@gmail.com (Anurup M)
Date: Wed, 16 Nov 2016 11:24:17 +0530
Subject: [RESEND PATCH v1 05/11] dt-bindings: perf: hisi: Add Devicetree
 bindings for Hisilicon SoC PMU
In-Reply-To: <20161115095148.GA29104@leverpostej>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-6-git-send-email-anurup.m@huawei.com>
 <20161110183040.GD10137@leverpostej> <58290014.2020401@gmail.com>
 <20161115095148.GA29104@leverpostej>
Message-ID: <582BF489.6040506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 15 November 2016 03:21 PM, Mark Rutland wrote:
> On Mon, Nov 14, 2016 at 05:36:44AM +0530, Anurup M wrote:
>> On Friday 11 November 2016 12:00 AM, Mark Rutland wrote:
>>> On Thu, Nov 03, 2016 at 01:42:01AM -0400, Anurup M wrote:
>>>> +	- scl-id : The Super Cluster ID. This can be the ID of the CPU die
>>>> +		   or IO die in the chip.
>>> What's this needed for?
>> This is used as suffix to the PMU name. hisi_l3c<scl-id>. (hisi_l3c2
>> - for scl-id = 2).
>> This is to identify the pmu correspond to which CPU die in the socket.
>>>> +	- num-events : No of events supported by this PMU device.
>>>> +
>>>> +	- num-counters : No of hardware counters available for counting.
>>> This isn't probeable or well-known?
>> My idea is to have the common properties of SoC PMU added here.
>> The num-events, num-counters etc. So that handling can be made
>> common in the driver.
>> Is it not recommended? Please share your comments.
> This feels like something that should be well-known for the programming
> model of the device. If the number of events and/or counters shange, I'd
> expect other things to also change such that the device is no longer
> compatible with previous versions.
>
> [...]
>
Agreed, it is possible that the versions can be still incompatible. 
Shall move it to
driver in v2.

>> The below two properties (module-id, cfgen-map) differs between
>> chips hip05/06 and hip07.
> The module-id property sounds like a HW description, but it's not
> entirely clear to me what cfgen-map is; more comments on that below.
>
>> Please suggest.
>>>> +	- module-id : Module ID to input for djtag. This property is an array of
>>>> +		      module_id for each L3 cache banks.
>>>> +
>>>> +	- num-banks : Number of banks or instances of the device.
>>> What's a bank? Surely they have separate instances of the PMU?
>> Yes each bank is a separate instance of PMU.
>> If it is recommended to have each L3 cache bank registered as
>> separate PMU with perf, then this property will be removed.
> Generally, I think that separate instances are preferable.
>
>>> What order are these in?
>> The bank number will start from "1" till "4" for L3 cache as there
>> are four banks in hip05/06/07 chips.
>>>> +	- cfgen-map : Config enable array to select the bank.
>>> Huh?
> As above, it's not clear to me what this property represents. Could you
> please clarify?
This property is used to select the bank. The naming lead to confusion.
I shall change it to bank_select.
If it is recommended to register each L3 cache bank as separate PMU then
this property will be moved to driver.

Thanks
Anurup
>
> Thanks,
> Mark.
