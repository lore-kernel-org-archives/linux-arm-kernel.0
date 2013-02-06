From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 6 Feb 2013 23:07:50 +0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <20130205233045.GQ25185@atomide.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
 <20130205040721.GE25185@atomide.com>
 <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
 <CAN1soZy0g3kWRm-d3gB4LmobrNTR6WVia38maS_fXbp4qmFayA@mail.gmail.com>
 <20130205233045.GQ25185@atomide.com>
Message-ID: <CAD6h2NSwnMk9c_vVq51ccv3PART0ZVAnm3v3kFLwz+S+nrOK2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2013 07:30, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@gmail.com> [130205 05:55]:
>>
>> Maybe it didn't cover your case. It seems that there's only one bit
>> for bias in your case.
>> You can control MMC BIAS enable or disable. And there's neither pullup
>> nor pulldown.
>> Is it right?
>
> Yes for this register there are no pulls. But I there are others that
> have pull bits.
>
>>      So I will need both config BIAS_ENABLE & config BIAS_DISABLE.
>> Driver switches between BIAS_ENABLE & BIAS_DISABLE.
>
> I'd like to avoid mapping both enable and disable for everything
> which seems bloated..
>

pinctrl-coh901 driver already uses PIN_CONFIG_BIAS_DISABLE without argument.

I think that it's better to use both BIAS_ENABLE & BIAS_DISABLE. Otherwise,
I need to update pinctrl-coh901 driver with updating the interface.
The work is a little
large.

Maybe we can use another name, PIN_CONFIG_BIAS_AUTOPULL. Then we can
distinguish it from PULL_UP & PULL_DOWN without any confusion. What's your
opinion?

Regards
Haojian
