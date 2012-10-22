From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 22 Oct 2012 18:09:36 +0800
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <20121019191333.GT4730@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <20121019191333.GT4730@atomide.com>
Message-ID: <CAN1soZzE_tTkmPBechvUcdAbWKSScwcaqe_cb0TTmnRJi9gtRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2012 at 3:13 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:08]:
>> Add pinconf generic support with POWER SOURCE, BIAS PULL.
> ...
>
>> +     case PIN_CONFIG_POWER_SOURCE:
>> +             if (pcs->psmask == PCS_OFF_DISABLED
>> +                     || pcs->psshift == PCS_OFF_DISABLED)
>> +                     return -ENOTSUPP;
>> +             data &= pcs->psmask;
>> +             data = data >> pcs->psshift;
>> +             *config = data;
>> +             return 0;
>> +             break;
>
> Hmm, only slightly related to this patch, mostly a generic
> question to others: Do others have any mux registers with
> status bits for things like PIN_CONFIG_POWER_SOURCE?
>
> I could use PIN_CONFIG_POWER_SOURCE for controlling the PBIAS
> for omap MMC. But there's also a status bit that needs to be
> checked for that. I think there was some other similar mux
> register for USB PHY that has a status register.
>
> So I'm wondering should the checking for status bit be handled
> in the pinctrl consume driver? Or should we have some bindings
> for that?
>

Do you mean that the status register only exists in USB PHY controller or
MMC controller?

If so, could we use regulator framework in USB PHY or MMC driver?

Regards
Haojian
