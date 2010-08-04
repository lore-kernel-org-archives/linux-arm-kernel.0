From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Aug 2010 11:37:33 +0800
Subject: [PATCH] [ARM] pxa/cm-x300: fix ffuart registration
In-Reply-To: <4C556422.3060901@compulab.co.il>
References: <1279612732-5906-1-git-send-email-grinberg@compulab.co.il>
	<AANLkTikxIFryvGJeCRMPrGrdcPXaEDPjsgEozsHbndwR@mail.gmail.com>
	<4C556422.3060901@compulab.co.il>
Message-ID: <AANLkTimiriUNY+NyOz5vwLzX05zUjxojbCaDgQrbw+1J@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 1, 2010 at 8:10 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 07/20/10 13:54, Eric Miao wrote:
>> On Tue, Jul 20, 2010 at 9:58 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>
>>> ffuart is available on cm-x300 only with pxa300.
>>>
>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>
>> Applied.
>>
>
> I can see it neither in fix, nor in devel branches on your git.kernel.org.
> Do you keep it locally?

Sorry it's in my local tree and missed the -rc phase. I'll push it within
this merge window. Cc'ed stable and GregKH.

Greg,

Could you help pick this simple oneliner to -stable? Or we'd better
wait a while until this appears in Linus' tree?

>
> Thanks
>
>>
>>> ---
>>> ?arch/arm/mach-pxa/cm-x300.c | ? ?3 ++-
>>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
>>> index fdda6be..d717b49 100644
>>> --- a/arch/arm/mach-pxa/cm-x300.c
>>> +++ b/arch/arm/mach-pxa/cm-x300.c
>>> @@ -745,9 +745,10 @@ static void __init cm_x300_init(void)
>>> ?{
>>> ? ? ? ?cm_x300_init_mfp();
>>>
>>> - ? ? ? pxa_set_ffuart_info(NULL);
>>> ? ? ? ?pxa_set_btuart_info(NULL);
>>> ? ? ? ?pxa_set_stuart_info(NULL);
>>> + ? ? ? if (cpu_is_pxa300())
>>> + ? ? ? ? ? ? ? pxa_set_ffuart_info(NULL);
>>>
>>> ? ? ? ?cm_x300_init_da9030();
>>> ? ? ? ?cm_x300_init_dm9000();
>>> --
>>> 1.7.1
>>>
>>>
>>>
>>
>
> --
> Regards,
> Igor.
>
>
