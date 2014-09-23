From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Tue, 23 Sep 2014 18:52:06 +0530
Subject: [PATCH/RFC 0/2] serial: samsung: add support for early console
In-Reply-To: <542170D9.4020605@samsung.com>
References: <1411391655-6291-1-git-send-email-m.szyprowski@samsung.com>
 <CAGOxZ51aghOqbZuv34TuBuQdKjmHdkhaYJvH=VxNjxb-pZKE8w@mail.gmail.com>
 <542170D9.4020605@samsung.com>
Message-ID: <CAGOxZ52yeT6V_vgoma6b4LMhO92sYGptUAXx5Er1Ep_1=nBJzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Sep 23, 2014 at 6:38 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On 2014-09-23 14:53, Alim Akhtar wrote:
>>
>> Hi Marek,
>>
>> On Mon, Sep 22, 2014 at 6:44 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>>
>>> Hello,
>>>
>>> This patchset adds support for early console defined in device tree. As
>>> an example, DTS files for all Exynos4 based machines are updated with
>>> the correct value for common chosen/sdtout property.
>>>
>>> To get it fully functional additional improvements (support for
>>> early_ioremap) are needed in early console code.
>>>
>> Is these really tested?
>
>
> I've tested it on Exynos4412 based OdroidU3 board. It works fine, although
> early console is not initialized as early as it might be. That's the only
> drawback, besides that it works fine.
>
>> So that mean we need to wait till __ioremap__ support available for ARM.
>> How to take this forward then? Here is a platform (exynos7) which
>> needs earlycon support for debugging some of the early core things and
>> ARM64 has ioremap support as well. There is no reason why we should
>> hold earlycon support for exyons7.
>
>
> I prefer to simply merge the patch as is. Once early con gets full
> functionality, all required samsung code will be already in then.
>
Thats good then, I was thinking you (or someone else, might be) are
going to hold this till __ioremap__ gets added for ARM.
>
>> I see two solution here:
>> 1> How about re-spin patch-1 which will just add ealrycon support for
>> __exynos4210__ serial type only? And rest of the types can be added as
>> incremental patches, as and when ioremap for ARM available.
>> Atleast this approch will solve exynos7 problem of not having earlycon
>> support.
>> And This patch can be tested on exynos7 (I can do that).
>> 2> Take  my patch which is working and tested for exynos7 and can be
>> easily extended and generalized when ioremap for ARM is available.
>>
>> My preference would be the the first one.
>> Let me know your thoughts please.
>> In case you are ok with 1st approach, can you please re-spin patch1
>> with needed changes?
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>



-- 
Regards,
Alim
