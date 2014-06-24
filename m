From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 24 Jun 2014 12:58:15 -0400
Subject: [PATCH v2 0/8] Add Keystone PCIe controller driver
In-Reply-To: <53A9A290.7020407@ti.com>
References: <20140623053249.GD2666@pratyush-vbox> <53A85ACE.9070506@ti.com>
 <53A9A290.7020407@ti.com>
Message-ID: <53A9AE27.2050504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2014 12:08 PM, Murali Karicheri wrote:
> Pratyush,
>
> On 06/23/2014 12:50 PM, Santosh Shilimkar wrote:
>>
>>
>>
>> -------- Original Message --------
>> Subject: Re: [PATCH v2 0/8] Add Keystone PCIe controller driver
>> On Sat, Jun 21, 2014 at 03:05:30AM +0800, Arnd Bergmann wrote:
>>> On Friday 20 June 2014 13:11:37 Santosh Shilimkar wrote:
>>
>>>>>
>>>> Arnd suggestion was to have the version 3.65 code in generic place
>>>> since
>>>> its IP specific and just in case some other vendor using the same
>>>> version
>>>> can leverage the code.
>>
>> Sorry, I do not follow PCIe mailing list these days, doing something else
>> now. So coming to this topic a bit delayed.
>>
> My Apologies for the email format as I mysteriously lost this email and
> had to resort to a forwarded email to respond to this.
>
> Let us have the discussion on this thread as I lost the original emails.
>>>>
>>>> Concern here seems toe really those name of the files. I can't think of
>>>> any other appropriate name.
>>>
>>> We should definitely keep the version in the DT "compatible" strings
>>> wherever we know it. Regarding a better file name, I have no idea.
>>
>> In my opinion, we do not need any of dw-v3_65 files, as code in these
>> files will not be usable by other vendors.
>>
>> Anything which is implemented in application space, will not be same
>> across all IP users. For example, MSI0_IRQ_ENABLE_SET has been defined
>> at offset 0x108 in keystone PCIe application space.Other vendor may
>> not have this register at the same offset. Moreover, other vendors are
>> not even obliged to implement MSI Enable signals in same way, so
>> internal bit definition of the register may change.
>>
>> Therefore code is not reusable if all register offset and bit
>> definitions are not same across vendors. So, in case of DW driver none
>> of the code which are accessed using va_app_base should go to common
>> area.
>>
>
> I think based on the response far on this issue, it is best to keep
> the Application specific code as part of Keystone driver and in
> future if there is any driver that has similar application register
> implemented. we can refactor the code and re-use.
>
> My V3 will revert back to implementation similar to RFC. Also since this
> is individual h/w specific, there is no no need for a compatibility as
> well. Will use keystone specific compatibility string for this.
>
> Arnd, hope this is fine. Please respond if you still think a
> compatibility string is needed.

On a second thought, I think it is better to keep the compatibility
string to differentiate the h/w and do any old h/w specific initialization.

Thanks and regards,

Murali
>
> Murali
>
>> Pratyush
>>
>>>
>>> Arnd
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
