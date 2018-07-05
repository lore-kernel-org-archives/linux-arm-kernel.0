From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Thu, 5 Jul 2018 09:58:16 +0530
Subject: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
In-Reply-To: <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
 <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan>
 <52724c9d-4650-9095-fb68-c4dff21a48f6@codeaurora.org>
 <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com>
Message-ID: <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/5/2018 4:49 AM, Rafael J. Wysocki wrote:
> On Wed, Jul 4, 2018 at 8:09 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
>>>> Adding Ulf and Marek.
>>>>
>>>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
>>>>> Add a flag to autoremove the device links on supplier driver
>>>>> unbind. This obviates the need to explicitly delete the link
>>>>> in the remove path.
>>>>> We remove these links only when the supplier's link to its
>>>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>>>>>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: linux-doc at vger.kernel.org
>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>> Cc: linux-pm at vger.kernel.org
>>>>> Cc: linux-arm-msm at vger.kernel.org
>>>>> ---
>>>> Hi Rafael, et al.
>>>>
>>>> Gentle ping.
>>>> Do you have comments on this series. I would really like to conclude
>>>> these
>>>> device link additions sooner, and get things moving on the long awaited
>>>> arm-smmu clock/runtime support series.
>>>>
>>>> Thanks again for reviewing these patches.
>>> They are fine by me.
>>>
>>> I can queue them up for 4.19 if no one has objections (Greg in
>>> particular).
>>
>> Hi Rafael,
>>
>> I will resubmit these 2 patches as part of the arm-smmu series, as one
>> of the patch in the series depends on addition of
>> DL_FLAG_AUTOREMOVE_SUPPLIER.
>> So these 2 patches and arm-smmu series should go together.
>> Can you please consider givnig your Ack?
> I would prefer to apply them myself to be honest and put them on an
> public git branch for you to pull from.

Sure. Fine with me. I will base the smmu patches on your branch.

Thanks
Vivek
>
> Thanks,
> Rafael
