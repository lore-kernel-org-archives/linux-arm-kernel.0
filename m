From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Oct 2013 10:14:29 +0200
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <051069C10411E24D9749790C498526FA1BE027EA@SJEXCHMB12.corp.ad.broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-4-git-send-email-syin@broadcom.com>
 <CACRpkdZah4fFuJL2Vh5JmbBCgnekg8MKqMWHzeheOx3N1Kzwng@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BE027EA@SJEXCHMB12.corp.ad.broadcom.com>
Message-ID: <CACRpkdarPC+LxAAezT2LRiz=Y2RduUsb75YYHUgq7HqePzkD3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 1:48 AM, Sherman Yin <syin@broadcom.com> wrote:

>>> +static const struct capri_cfg_param capri_pinconf_params[] = {
>>> +       {"brcm,hysteresis",     CAPRI_PINCONF_PARAM_HYST},
>>> +       {"brcm,pull",           CAPRI_PINCONF_PARAM_PULL},
>>> +       {"brcm,slew",           CAPRI_PINCONF_PARAM_SLEW},
>>> +       {"brcm,input_dis",      CAPRI_PINCONF_PARAM_INPUT_DIS},
>>> +       {"brcm,drive_str",      CAPRI_PINCONF_PARAM_DRV_STR},
>>> +       {"brcm,pull_up_str",    CAPRI_PINCONF_PARAM_PULL_UP_STR},
>>> +       {"brcm,mode",           CAPRI_PINCONF_PARAM_MODE},
>>> +};
>>
>>As well as all this stuff...
>
> OK.  Will see if I can find something suitable for "input disable" and "mode"

Let's discuss this. What exactly does "input disable" and "mode"
mean, in electrical terms?

When you come down to what actually happens it may turn out that
"input disable" is PIN_CONFIG_OUTPUT, which implicitly turns
off input does it not?

Yours,
Linus Walleij
