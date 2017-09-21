From: al.cooper@broadcom.com (Al Cooper)
Date: Thu, 21 Sep 2017 15:16:34 -0400
Subject: [PATCH V5 1/4] soc: brcmstb: Add Product ID and Family ID helper
 functions
In-Reply-To: <0deddef3-fc3e-67be-12e8-9fbd84f24314@ti.com>
References: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
 <1503683495-11766-2-git-send-email-alcooperx@gmail.com>
 <3aefb1ca-827d-6ebf-03c6-1f0d41e5da5c@gmail.com>
 <0deddef3-fc3e-67be-12e8-9fbd84f24314@ti.com>
Message-ID: <CAGh=XAAzjvSpHK_oaj2OwTswdtCpfKUhg-nL+M_4jM92yMTs=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

I ran checkpatch on all my patches before submitting them and didn't
get any warnings. It looks like you may be running checkpatch with the
"--subjective" option. Is this a requirement and if so are there any
other checkpatch options I should be using?

Thanks
Al

On Thu, Sep 21, 2017 at 4:54 AM, 'Kishon Vijay Abraham I' via
BCM-KERNEL-FEEDBACK-LIST,PDL
<bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
> Hi,
>
> On Saturday 02 September 2017 07:45 AM, Florian Fainelli wrote:
>>
>>
>> On 08/25/2017 10:51 AM, Al Cooper wrote:
>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>
> I get the following checkpatch warning
> CHECK: Macro argument reuse 'reg' - possible side-effects?
> #110: FILE: include/linux/soc/brcmstb/brcmstb.h:4:
> +#define BRCM_ID(reg)   ((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
>
> Can you fix it and resend. While at that also add commmit log.
>
> Thanks
> Kishon
>
>>
>>> ---
>>>  drivers/soc/bcm/brcmstb/common.c    | 12 ++++++++++++
>>>  include/linux/soc/brcmstb/brcmstb.h | 10 ++++++++++
>>>  2 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
>>> index b6195fd..184dbf5 100644
>>> --- a/drivers/soc/bcm/brcmstb/common.c
>>> +++ b/drivers/soc/bcm/brcmstb/common.c
>>> @@ -40,6 +40,18 @@ bool soc_is_brcmstb(void)
>>>      return of_match_node(brcmstb_machine_match, root) != NULL;
>>>  }
>>>
>>> +u32 brcmstb_get_family_id(void)
>>> +{
>>> +    return family_id;
>>> +}
>>> +EXPORT_SYMBOL(brcmstb_get_family_id);
>>> +
>>> +u32 brcmstb_get_product_id(void)
>>> +{
>>> +    return product_id;
>>> +}
>>> +EXPORT_SYMBOL(brcmstb_get_product_id);
>>> +
>>>  static const struct of_device_id sun_top_ctrl_match[] = {
>>>      { .compatible = "brcm,bcm7125-sun-top-ctrl", },
>>>      { .compatible = "brcm,bcm7346-sun-top-ctrl", },
>>> diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
>>> index 337ce41..23e4dc9 100644
>>> --- a/include/linux/soc/brcmstb/brcmstb.h
>>> +++ b/include/linux/soc/brcmstb/brcmstb.h
>>> @@ -1,10 +1,20 @@
>>>  #ifndef __BRCMSTB_SOC_H
>>>  #define __BRCMSTB_SOC_H
>>>
>>> +#define BRCM_ID(reg)        ((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
>>> +#define BRCM_REV(reg)       ((u32)reg & 0xff)
>>> +
>>>  /*
>>>   * Bus Interface Unit control register setup, must happen early during boot,
>>>   * before SMP is brought up, called by machine entry point.
>>>   */
>>>  void brcmstb_biuctrl_init(void);
>>>
>>> +/*
>>> + * Helper functions for getting family or product id from the
>>> + * SoC driver.
>>> + */
>>> +u32 brcmstb_get_family_id(void);
>>> +u32 brcmstb_get_product_id(void);
>>> +
>>>  #endif /* __BRCMSTB_SOC_H */
>>>
>>
