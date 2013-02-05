From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 15:30:45 -0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <CAN1soZy0g3kWRm-d3gB4LmobrNTR6WVia38maS_fXbp4qmFayA@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
 <20130205040721.GE25185@atomide.com>
 <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
 <CAN1soZy0g3kWRm-d3gB4LmobrNTR6WVia38maS_fXbp4qmFayA@mail.gmail.com>
Message-ID: <20130205233045.GQ25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [130205 05:55]:
> 
> Maybe it didn't cover your case. It seems that there's only one bit
> for bias in your case.
> You can control MMC BIAS enable or disable. And there's neither pullup
> nor pulldown.
> Is it right?

Yes for this register there are no pulls. But I there are others that
have pull bits.

>      So I will need both config BIAS_ENABLE & config BIAS_DISABLE.
> Driver switches between BIAS_ENABLE & BIAS_DISABLE.

I'd like to avoid mapping both enable and disable for everything
which seems bloated..
 
>      or 2) 4 params
>            bias-enable = <user setting of bias value, expected enable
> value (w pullup & pulldown), expected disable value (w/o pullup &
> pulldown), mask (pullup & pulldown)>;
>            bias-pullup = <user setting of bias value, expected bias
> pullup value, expected bias pullup disable value, mask of pullup>;
>            bias-pulldown ...
>      Driver switches among BIAS_DISABLE, BIAS_PULLDOWN, BIAS_PULLUP.
> It seems that BIAS_ENABLE is redundant operation at here.

..so this 4 params option makes sense to me assuming it works
for your case.
 
> There're two usage for all three cases. Which one do you like?

It seems that the 4 params option is most generic to me.

Regards,

Tony
