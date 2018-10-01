From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 1 Oct 2018 09:25:08 +0200
Subject: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
In-Reply-To: <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
 <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
 <20180928224109.GS5662@atomide.com>
 <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
 <d14cc796-8644-41a3-5135-299bd8820204@gmail.com>
 <20180929002753.GT5662@atomide.com>
 <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
Message-ID: <20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c~Za0l11ceE1868218682eucas1p2w@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
unfortunately, I don't work at kernel anymore. That would be great, if you could take over those patches and finish the 
work.
Best regards,
Maciej

On 09/29/2018 02:44 AM, Dmitry Osipenko wrote:
> On 9/29/18 3:27 AM, Tony Lindgren wrote:
>> * Dmitry Osipenko <digetx@gmail.com> [180928 23:55]:
>>> On 9/29/18 2:17 AM, Dmitry Osipenko wrote:
>>>> On 9/29/18 1:41 AM, Tony Lindgren wrote:
>>>>> I'm still getting these errors after init:
>>>>
>>>> Thank you very much again, seems I got what's wrong with your case. The ti-abb-regulator driver sets the "abb->current_info_idx = -EINVAL" on probe and that value is getting updated only after the first voltage change, hence _regulator_get_voltage() returns -22.
>>
>> OK that's starting to make some sense now thanks.
>>
>>>> Please try this patch:
>>>
>>> I've revised the patch and here is the current final version.
>>
>> Hey cool this one works now :) I suggest you rework the whole series
>> with these fixes. I recall the series had a problem with git bisect
>> too between the patches. It will make life easier for other people
>> who may need to git bisect these patches.
> 
> Awesome! There are few other things in this patchset that also need fixing. I've asked Maciej if he's going to continue working on the patches, waiting for the answer. I can pick up the patches and try to finish the work if necessary.
> 
> 
