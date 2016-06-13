From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 13 Jun 2016 09:59:21 -0600
Subject: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
In-Reply-To: <b7202ebbb30f2c715427fbb387129e9c@codeaurora.org>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
 <575EBD13.8080808@codeaurora.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782E15@lhreml507-mbx>
 <b7202ebbb30f2c715427fbb387129e9c@codeaurora.org>
Message-ID: <036882b9-b781-cb56-2bcf-35afb21b2812@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/13/2016 9:12 AM, okaya at codeaurora.org wrote:
> On 2016-06-13 10:29, Gabriele Paoloni wrote:
>> Hi Sinan
>>
>>> -----Original Message-----
>>> From: Sinan Kaya [mailto:okaya at codeaurora.org]
>>> Sent: 13 June 2016 15:03
>>> To: Gabriele Paoloni; liudongdong (C); helgaas at kernel.org;
>>> arnd at arndb.de; will.deacon at arm.com; catalin.marinas at arm.com;
>>> rafael at kernel.org; hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com;
>>> jchandra at broadcom.com; tn at semihalf.com
>>> Cc: robert.richter at caviumnetworks.com; mw at semihalf.com;
>>> Liviu.Dudau at arm.com; ddaney at caviumnetworks.com; Wangyijing;
>>> Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
>>> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>>> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
>>> acpi at lists.linaro.org; jcm at redhat.com; andrea.gallo at linaro.org;
>>> dhdang at apm.com; jeremy.linton at arm.com; cov at codeaurora.org; Chenxin
>>> (Charles); Linuxarm
>>> Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space
>>> accessors against platfrom specific ECAM quirks
>>>
>>> On 6/13/2016 9:54 AM, Gabriele Paoloni wrote:
>>> > As you can see here Liudongdong has replaced oem_revision with
>>> > oem_table_id.
>>> >
>>> > Now it seems that there are some platforms that have already shipped
>>> > using a matching based on the oem_revision (right Jon?)
>>> >
>>> > However I guess that if in FW they have defined oem_table_id properly
>>> > they should be able to use this mechanism without needing to a FW
>>> update.
>>> >
>>> > Can these vendors confirm this?
>>> >
>>> > Tomasz do you think this can work for Cavium Thunder?
>>> >
>>> > Thanks
>>> >
>>> > Gab
>>>
>>> Why not have all three of them?
>>>
>>> The initial approach was OEM id and revision id.
>>>
>>> Jeff Hugo indicated that addition (not removing any other fields) of
>>> table id
>>> would make more sense.
>>
>> Mmm from last email of Jeff Hugo on "[RFC PATCH 1/3] pci, acpi: Match
>> PCI config space accessors against platfrom specific ECAM quirks."
>>
>> I quote:
>>
>>  "Using the OEM revision
>>  field does not seem to be appropriate since these are different
>>  platforms and the revision field appears to be for the purpose of
>>  tracking differences within a single platform.  Therefore, Cov is
>>  proposing using the OEM table id as a mechanism to distinguish
>>  platform A (needs quirk applied) vs platform B (no quirks) from the
>>  same OEM."
>>
>> So it looks to me that he pointed out that using the OEM revision field
>> is wrong...and this is why I have asked if replacing it with the table
>> id can work for other vendors....
>>
>> Thanks
>>
>> Gab
>>
>
> I had an internal discussion with jeff and cov before posting on the
> maillist.
>
> I think there is missing info in the email.
>
> Usage of oem id + table id + revision is ok.
>
> Usage of oem id + revision is not ok as one oem can build multiple chips
> with the same oem id and revision id but different table id. Otherwise,
> we can run out of revisions very quickly.

Agreed.

I'm sorry for the confusion.  My intent was to point out that revision 
alone appeared insufficient to address all the identified problems, but 
I believe there is still a case for using revision. Table id is useful 
for differentiating between platforms/chips.  Revision is useful for 
differentiation between different versions of a single platform/chip 
assuming the silicon is respun or some other fix is applied.  Both solve 
different scenarios, and I'm not aware of a reason why they could not be 
used together to solve all currently identified cases.

>
>>
>>>
>>> --
>>> Sinan Kaya
>>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center,
>>> Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>>> Linux Foundation Collaborative Project
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Jeffrey Hugo
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
