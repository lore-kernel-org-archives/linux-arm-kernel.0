From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 7 Feb 2018 12:06:48 +0000
Subject: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <CACRpkdZn+A9Pv0ACQkjvq-2At39Ni9oB5Od=6+-5zk9b2qgNtA@mail.gmail.com>
References: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
 <CACRpkdZn+A9Pv0ACQkjvq-2At39Ni9oB5Od=6+-5zk9b2qgNtA@mail.gmail.com>
Message-ID: <AM3PR04MB3069D6F546F6DBB2FBDE07980FC0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: 2018?2?7? 17:22
> To: Jacky Bai <ping.bai@nxp.com>; Lucas Stach <l.stach@pengutronix.de>; A.s.
> Dong <aisheng.dong@nxp.com>; Gary Bisson
> <gary.bisson@boundarydevices.com>; Vladimir Zapolskiy <vz@mleia.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> dl-linux-imx <linux-imx@nxp.com>; Jacky Bai <jacky.baip@gmail.com>
> Subject: Re: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
> imx6sll
> 
> On Wed, Feb 7, 2018 at 3:07 AM, Bai Ping <ping.bai@nxp.com> wrote:
> 
> > Add pinctrl binding doc update for imx6sll.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > ---
> > changes v2-v3:
> >  - add generic config binding
> 
> > +Optional Properties:
> > +- drive-strength               Integer. Controls Drive Strength
> > +                                       0: HI-Z
> > +                                       1: 260 ohm at 3.3v, 150
> ohm at 1.8v
> > +                                       2: 130 ohm at 3.3v, 75
> ohm at 1.8v
> > +                                       3: 86 ohm at 3.3v, 50
> ohm at 1.8v
> > +                                       4: 65 ohm at 3.3v, 37
> ohm at 1.8v
> > +                                       5: 52 ohm at 3.3v, 30
> ohm at 1.8v
> > +                                       6: 43 ohm at 3.3v, 25
> ohm at 1.8v
> > +                                       7: 37 ohm at 3.3v, 21
> ohm at 1.8v
> 
> HOW INTERESTING.
> 
> I am discussing this a lot with Lucas Stach right now, and in his SoC i.MX8MQ
> that first resistance is said to be 255 Ohm etc.
> 
> Plus it seems he's missing the figures for 1.8V.
> 

>From the reference on my hand, it's

000  HI-Z ? Output driver is disabled (Hi-Z State)
001  255_OHM ? 255 Ohm @3.3V, 240 Ohm @2.5V, 230 Ohm @1.8V, 265 Ohm @1.2V
010  105_OHM ? 105 Ohm @3.3V, 100 Ohm @2.5V, 85 Ohm @1.8V, 110 Ohm @1.2V
011  75_OHM ? 75 Ohm @3.3V, 70 Ohm @2.5V, 60 Ohm @1.8V, 80 Ohm @1.2V
100  85_OHM ? 85 Ohm @3.3V, 80 Ohm @2.5V, 75 Ohm @1.8V, 90 Ohm @1.2V
101  65_OHM ? 65 Ohm @3.3V, 60 Ohm @2.5V, 55 Ohm @1.8V, 65 Ohm @1.2V
110  45_OHM ? 45 Ohm @3.3V, 45 Ohm @2.5V, 40 Ohm @1.8V, 50 Ohm @1.2V
111  40_OHM ? 40 Ohm @3.3V, 40 Ohm @2.5V, 33 Ohm @1.8V, 40 Ohm @1.2V

Which makes things a bit complicated as the value changes when voltage varies.

> We're discussing whether this is used for impedance matching and what not.
> We really need someone inside NXP to show us the way.
> 
> Anyways, I really need the two of you to discuss this, and I will forward my
> conversation with Lucas to you.
> 
> If you can fish around a bit and tell us what this is used for and how:
> 
> - Is the intended usage for impedance matching?
> - Does it control how many totem-poles are activated on the
>   output pad?
> 

I already forwarded the question to the IP owner from our IC design team,
just as I replied in another mail to you.

Regards
Dong Aisheng

> would all be very grateful.
> 
> > +- drive-open-drain             Bool. Enable Pin Open-drian
> 
> Open-drain?
> 
> Yours,
> Linus Walleij
