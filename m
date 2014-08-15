From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 15 Aug 2014 16:33:09 +0800
Subject: [PATCH 1/2] ARM: pxa: ssp: provide platform_device_id for PXA3xx
In-Reply-To: <53EC74B4.1050007@gmail.com>
References: <1407959959-4977-1-git-send-email-zonque@gmail.com>
 <CAN1soZz0Fo_PNvc1dK7d9ZU49Pi0FortL4k1dwAjHEDZNcf_zg@mail.gmail.com>
 <53EC74B4.1050007@gmail.com>
Message-ID: <CAN1soZyj+ddcuP60F5kB2pwUYGYG7bF6mFckoak97xr6n7wCYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 4:35 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Haojian,
>
> On 08/14/2014 04:08 AM, Haojian Zhuang wrote:
>> On Thu, Aug 14, 2014 at 3:59 AM, Daniel Mack <zonque@gmail.com> wrote:
>>> Provide an explicit match string for PXA3xx SSP ports.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> ---
>>>  arch/arm/plat-pxa/ssp.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
>>> index 3ea0290..1f5ee17 100644
>>> --- a/arch/arm/plat-pxa/ssp.c
>>> +++ b/arch/arm/plat-pxa/ssp.c
>>> @@ -258,6 +258,7 @@ static const struct platform_device_id ssp_id_table[] = {
>>>         { "pxa25x-ssp",         PXA25x_SSP },
>>>         { "pxa25x-nssp",        PXA25x_NSSP },
>>>         { "pxa27x-ssp",         PXA27x_SSP },
>>> +       { "pxa3xx-ssp",         PXA3xx_SSP },
>>>         { "pxa168-ssp",         PXA168_SSP },
>>>         { "pxa910-ssp",         PXA910_SSP },
>>>         { },
>>> --
>
>> I don't agree on this. SSP1,SSP2,SSP3 on pxa3xx are same with pxa27x.
>> So we reuse the name.
>> For the new SSP4, we create pxa3xx_device_ssp4.
>
> Well, the problem is that the code in sound/soc/pxa/pxa-ssp.c is full of
> checks like "ssp->type == PXA3xx_SSP", but unless the devices are
> instantiated via DT, this value is never set appropriately, not even for
> ssp4.
>
> That's a regression caused by 972a55b62 ("ASoC: fix pxa-ssp compiling
> issue under mach-mmp"), btw, that added the PXA3xx_SSP enum value but
> forgot to make sure it is actually used.
>
> Hence, this commit could even get a stable tag for 3.5+.
>
>
Yes, you're right. We should append this string.
