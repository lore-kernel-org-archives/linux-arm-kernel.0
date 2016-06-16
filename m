From: Adam.Thomson.Opensource@diasemi.com (Opensource [Adam Thomson])
Date: Thu, 16 Jun 2016 08:40:45 +0000
Subject: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
In-Reply-To: <5761FDAA.1070802@rock-chips.com>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <CADR9n49m7anZpDbbb3=ZGBaacOuXc4F=Yid0eyMey1LfEJx8Pw@mail.gmail.com>
 <5761FDAA.1070802@rock-chips.com>
Message-ID: <2E89032DDAA8B9408CB92943514A0337D4643174@SW-EX-MBX01.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2016 02:15, Xing Zheng wrote:

> >> +       /* Enable Headset and 4 Buttons Jack detection */
> >> +       ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
> >> +                                   SND_JACK_HEADSET |
> > Should this also include SND_JACK_LINEOUT? da7219 differentiates
> > between the two so not including lineout means, for example, we can
> > miss jack insertion/removal events.
> >
> Hi Adam,
> 
> Could you please confirm Steve says that about SND_JACK_LINEOUT?
> 
> Thanks.

Hi Xing Zheng,

Yes, as Steve mentioned DA7219 does support SND_JACK_LINEOUT so we should really
include this here.
