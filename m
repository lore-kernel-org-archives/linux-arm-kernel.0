From: syin@broadcom.com (Sherman Yin)
Date: Fri, 11 Oct 2013 18:25:16 +0000
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <CACRpkdarPC+LxAAezT2LRiz=Y2RduUsb75YYHUgq7HqePzkD3Q@mail.gmail.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-4-git-send-email-syin@broadcom.com>
 <CACRpkdZah4fFuJL2Vh5JmbBCgnekg8MKqMWHzeheOx3N1Kzwng@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BE027EA@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdarPC+LxAAezT2LRiz=Y2RduUsb75YYHUgq7HqePzkD3Q@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BE03D43@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> +static const struct capri_cfg_param capri_pinconf_params[] = {
>>>> +       {"brcm,hysteresis",     CAPRI_PINCONF_PARAM_HYST},
>>>> +       {"brcm,pull",           CAPRI_PINCONF_PARAM_PULL},
>>>> +       {"brcm,slew",           CAPRI_PINCONF_PARAM_SLEW},
>>>> +       {"brcm,input_dis",      CAPRI_PINCONF_PARAM_INPUT_DIS},
>>>> +       {"brcm,drive_str",      CAPRI_PINCONF_PARAM_DRV_STR},
>>>> +       {"brcm,pull_up_str",    CAPRI_PINCONF_PARAM_PULL_UP_STR},
>>>> +       {"brcm,mode",           CAPRI_PINCONF_PARAM_MODE},
>>>> +};
>>>
>>>As well as all this stuff...
>>
>> OK.  Will see if I can find something suitable for "input disable" and "mode"
>
>Let's discuss this. What exactly does "input disable" and "mode"
>mean, in electrical terms?
>
>When you come down to what actually happens it may turn out that
>"input disable" is PIN_CONFIG_OUTPUT, which implicitly turns
>off input does it not?

I'm going to verify the details with our hardware team first, and will let you
know if we think we can use one of the existing generic parameters or if we
need a new one.

Regards,
Sherman
