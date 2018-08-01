From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 1 Aug 2018 15:28:02 +0530
Subject: [PATCH v8 2/4] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <AM0PR04MB4211B20B99E087177D0C06D8802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-3-o.rempel@pengutronix.de>
 <CABb+yY1ZusgN4UVxmUgXZS9ObGdLwFAL4XkW7F1yVb6Gq=9XPA@mail.gmail.com>
 <AM0PR04MB4211B20B99E087177D0C06D8802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY304PeP_G9NiRW+pkXod+bUnYdKaYxOgH7XjsGEqQ5TVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2018 at 2:28 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> Hi Jassi,
>
>> > +               The doorbell channels should be used with shared memory and
>> protocol
>> > +               level acknowledgment if needed.
>> > +
>> I would avoid this. People might get notions that they have to use shmem
>> with doorbell -- a trivial protocol might mean doing some fixed action (like
>> reset) whenever the doorbell rings.
>>
>
> That's right.
> i.MX8 using the general purpose interrupt for peripherals. No shmem needed.
> e.g. RTC, Watchdog and ON/OFF interrupt.
>
> BTW, this means the peripheral will use mailbox doorbell channels to handle
> Interrupts. Is there such user case in kernel we can refer to?
>
I don't find any publicly in kernel.
It should be simple though. Acquire the RX channel, and populate the
rx_callback() with the "interrupt" handler.
