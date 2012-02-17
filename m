From: zonque@gmail.com (Daniel Mack)
Date: Fri, 17 Feb 2012 14:44:18 +0100
Subject: [PATCH] ARM: OMAP: hsmmc: add max_freq field
In-Reply-To: <4EFC6992.4020501@gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
 <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
 <4EFC6992.4020501@gmail.com>
Message-ID: <CACTFLAMCoKfQbTe2RLTvi1_CH0nKzAOthAwrifNe2+F2sf3uPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping? Could anyone care for queueing this please?


On Thu, Dec 29, 2011 at 2:22 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 12/23/2011 04:40 PM, T Krishnamoorthy, Balaji wrote:
>> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 101cd31..8215ef9 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>> ? ? ? ?if (mmc_slot(host).vcc_aux_disable_is_sleep)
>>> ? ? ? ? ? ? ? ?mmc_slot(host).no_off = 1;
>>>
>>> - ? ? ? mmc->f_min ? ? ?= OMAP_MMC_MIN_CLOCK;
>>> - ? ? ? mmc->f_max ? ? ?= OMAP_MMC_MAX_CLOCK;
>>> + ? ? ? mmc->f_min = OMAP_MMC_MIN_CLOCK;
>>
>> Stray change for f_min ?
>
> No, this was intended. The indentation doesn't make sense anymore when
> not grouped with the f_max assignment.
>
> Other than that, what is necessary to get this picked? Tony? :)
>
>
> Thanks,
> Daniel
