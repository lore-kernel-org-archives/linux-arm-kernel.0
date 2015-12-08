From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 8 Dec 2015 21:08:24 +0800
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <5666D28C.4090305@linaro.org>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon> <5666D28C.4090305@linaro.org>
Message-ID: <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,



On 8 December 2015 at 20:52, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Lorenzo,
>
> On 12/08/2015 08:34 PM, Lorenzo Pieralisi wrote:
>>
>> On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei at linaro.org wrote:
>>>
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>>
>> [...]
>>
>>> +#if defined(__i386__) || defined(__x86_64__)
>>>   /*
>>>    * Check if firmware advertises firmware first mode. We need FF bit to
>>> be set
>>>    * along with a set of MC banks which work in FF mode.
>>>    */
>>>   static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr,
>>> void *data)
>>>   {
>>> -       return arch_apei_enable_cmcff(hest_hdr, data);
>>> +       if (!acpi_disable_cmcff)
>>
>>
>> Why do not you define the flag above in this file (move it out of x86 -
>> that's what I was aiming at in my previous reply) and remove this
>> ifdeffery
>> altogether (First firmware handling could apply to arm64 too according to
>> specs and ACPI on arm64 guidelines) ?
>
>
> If I understand it correctly, CMC (Corrected Machine Check) is for IA32
> only, see section 18.3.2.1 IA-32 Architecture Machine Check Exception
> in ACPI 6.0. for ARM64, we can use other type of error source for
> firmware first handling, such as Generic Hardware Error Source, did
> I miss something?

yes, that is why I try to use "#if defined(__i386__) ||
defined(__x86_64__)" instead of moving acpi_disable_cmcff out of x86
code to here.

And I thinks we also can do "arch_apei_enable_cmcff" -->
"apei_enable_ia_cmcff" because that is IA32 only.

Please correct me if I misunderstand something.  Thanks :-)

Great thanks for your feedback :-)

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
