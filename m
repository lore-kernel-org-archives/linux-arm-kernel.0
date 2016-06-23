From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Jun 2016 14:50:55 +0200
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
Message-ID: <576BDB2F.2070003@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2016 06:31 AM, Jassi Brar wrote:
> On Tue, Jun 21, 2016 at 3:32 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Add Amlogic Meson SoCs Message-Handling-Unit as mailbox controller
>> with 2 independent channels/links to communicate with a remote processor.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> .....
> 
>> +++ b/drivers/mailbox/meson_mhu.c
>> @@ -0,0 +1,199 @@
>> +/*
>> + * Copyright (C) 2016 BayLibre SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + * Heavily based on meson_mhu.c from :
>> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> 
> .........
>> +
>> +#define INTR_SET_OFS   0x0
>> +#define INTR_STAT_OFS  0x4
>> +#define INTR_CLR_OFS   0x8
>> +
>> +#define MHU_LP_OFFSET  0x10
>> +#define MHU_HP_OFFSET  0x1c
>> +
>> +#define TX_REG_OFFSET  0x24
>> +
> It seems only some register offsets have changed from arm_mhu. So
> maybe just adapt the arm_mhu driver to look for IP variant and assign
> corresponding offsets to set,stat,clr registers.

Hi Jassi,

It's a good idea, but adding the platform_driver support along the amba_bus probe will add a lot a code.
The meson_mhu is a very simple and short driver, I think it'll be simpler to maintain beeing separated.
And I'm not certain on how it's close of ARM's real IP.

Neil

> Cheers.
> 
