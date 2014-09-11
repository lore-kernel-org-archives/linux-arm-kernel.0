From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 10 Sep 2014 21:42:25 -0700
Subject: [PATCHv4 2/2] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <20140910084705.GB28488@arm.com>
References: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
 <1408477303-2640-3-git-send-email-lauraa@codeaurora.org>
 <20140826144023.GA22256@localhost> <540493DC.20909@codeaurora.org>
 <20140901154529.GF24594@arm.com>
 <CAMDttNf9nWutGNVT8f+f99SX8WtDNSBDN4uvpS+oJKNMdXs7xQ@mail.gmail.com>
 <20140910084705.GB28488@arm.com>
Message-ID: <54112831.6010800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/10/2014 1:47 AM, Will Deacon wrote:
> On Wed, Sep 10, 2014 at 04:58:01AM +0100, Zi Shen Lim wrote:
>> On Mon, Sep 1, 2014 at 8:45 AM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Mon, Sep 01, 2014 at 04:42:20PM +0100, Laura Abbott wrote:
>>>> On 8/26/2014 7:40 AM, Catalin Marinas wrote:
>>>>> On Tue, Aug 19, 2014 at 08:41:43PM +0100, Laura Abbott wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>> [...]
>>>>>> +static int change_memory_common(unsigned long addr, int numpages,
>>>>>> +                          pgprot_t set_mask, pgprot_t clear_mask)
>>>>>> +{
>>>>>> +  unsigned long start = addr;
>>>>>> +  unsigned long size = PAGE_SIZE*numpages;
>>>>>> +  unsigned long end = start + size;
>>>>>> +  int ret;
>>>>>> +  struct page_change_data data;
>>>>>> +
>>>>>> +  if (!IS_ALIGNED(addr, PAGE_SIZE)) {
>>>>>> +          addr &= PAGE_MASK;
>>
>> I don't see any uses of addr after this.
>> Perhaps we also meant to compute start and end?
>
>
> Actually, I think the alignment fixup should just be performed directly on
> start, but this is Laura's code so it would be good if she could confirm.
>
> Laura -- what's the right thing to do here? (sending a fix patch would be
> ideal :)
>
> Will
>

Yes this needs to be fixed. I'll send a patch out tomorrow.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
