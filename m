From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 17:34:35 +0530
Subject: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
In-Reply-To: <AM0PR04MB4211F722024F7F183774D592802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de>
 <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
 <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1DQbGnWL=HZc=xPLdJjKgkpdvCHmm6Pr6_MvERR=D56Q@mail.gmail.com>
 <AM0PR04MB4211F722024F7F183774D592802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY2uLgrJ9-NUnoXYXCqQ7_sQyWxF=wRQFM+cja0HbBox4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 5:25 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
>> Sent: Thursday, July 26, 2018 7:37 PM
>> To: A.s. Dong <aisheng.dong@nxp.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
>> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
>> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Sudeep Holla
>> <sudeep.holla@arm.com>; Devicetree List <devicetree@vger.kernel.org>;
>> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; , Sascha Hauer
>> <kernel@pengutronix.de>; , linux-arm-kernel at lists.infradead.org, linux-
>> mediatek at lists.infradead.org, srv_heupstream <linux-arm-
>> kernel at lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be
>> equal to 0
>>
>> On Thu, Jul 26, 2018 at 4:30 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> >> -----Original Message-----
>> >> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
>> >> Sent: Thursday, July 26, 2018 5:42 PM
>> >> To: Oleksij Rempel <o.rempel@pengutronix.de>
>> >> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>> >> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
>> >> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> >> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Sudeep Holla
>> >> <sudeep.holla@arm.com>; Devicetree List <devicetree@vger.kernel.org>;
>> >> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; , Sascha
>> >> Hauer <kernel@pengutronix.de>; ,
>> >> linux-arm-kernel at lists.infradead.org, linux-
>> >> mediatek at lists.infradead.org, srv_heupstream <linux-arm-
>> >> kernel at lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> >> Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to
>> >> be equal to 0
>> >>
>> >> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
>> >> <o.rempel@pengutronix.de>
>> >> wrote:
>> >> > From: Dong Aisheng <aisheng.dong@nxp.com>
>> >> >
>> >> > Mailbox devices may have only one channel which means the
>> >> > mbox-cells at least 1 does not make sense for this type devices.
>> >> > Let's remove that limitation to allow the mbox-cells to be equal to 0.
>> >> >
>> >> OK
>> >>
>> >> But please realise that you'll have to write more code -- implement
>> >> your own
>> >> of_xlate() callback.
>> >> Most developers would prefer to call the only channel as channel
>> >> number 0, and use the common of_xlate implementation.
>> >>
>> >
>> > Yes, that's true because the common of_xlate assuming the mbox-cells is 1.
>> > And there's already such users:
>> > arch/arm/boot/dts/bcm283x.dtsi
>> >
>> You mean that is a good thing, right?
>
> No, I mean there's similar HW in kernel already that only has one channel.
> Are you suggesting even for one channel mailbox, we should still use
> Mbox-cells 1 and use 'mboxes = <&mailbox 0>' in devicetree?
>
As i said, I am ok with the mbox-cells to be 0.

But if you have two instances of the controller, one with 4 channels
and the other with 1 channel. Then you can/should not have different
bindings.

And, if the controller can have only 1 channel, then please feel free
to have mbox-cells=0 and implement your own of_xlate().
