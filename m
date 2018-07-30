From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 30 Jul 2018 16:44:35 +0200
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
References: <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
 <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
 <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
Message-ID: <20180730144435.srxgohwgdhrmw2rz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 06:34:56PM +0530, Jassi Brar wrote:
> On Mon, Jul 30, 2018 at 1:05 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > Hi Aishen, Jassie,
> >
> > i'm lost in this discussion. Please, as soon as I need to add some
> > changes to my patches, notify me. Preferably on top for email.
> >
> I am ok with however you choose to implement, 8 unidirectional or 4
> bidirectional channels or whatever.
> 
> We just can't have protocol specific s/w modes in the controller drivers.
> 
> The best solution is to fix the SCU firmware. If that is _really_
> impossible, I provided a solution (3 cells work around). If you have a
> better idea please feel free to propose and implement that.
> 
> It will also help if you could share the user code of "scu-mode". If
> there is no such code (and we know the driver doesn't respect the
> "scu-mode" property) why do we even have that binding? Maybe drop it.

Tomorrow I have a time slot to address your generic iMX MU suggestions.
So, what is better, uni- or bi-directional channels? Should I implement
*all* (4TX+FIFO, 4RX+FIFO, 4TX-simple, 4RX-simple) channels in this run?
If yes, how should it be reflected in DT?
- 1 cell: &mu [0-15]
- 2 cells: &mu [0-7] [TX,RX]
- 3 cells: &mu [0-4] [FIFO,NOFIFO] [TX,RX]

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/0ff71b90/attachment.sig>
