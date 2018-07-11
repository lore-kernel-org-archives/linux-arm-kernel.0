From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 11 Jul 2018 16:14:10 +0530
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 4:07 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Wednesday, July 11, 2018 3:55 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> > <jassisinghbrar@gmail.com>; linux-kernel at vger.kernel.org; Oleksij Rempel
> > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo at kernel.org
> > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >
> > On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
> > > Hi Sascha,
> > >
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > > Sent: Tuesday, July 10, 2018 10:20 PM
> > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi
> > > > Brar <jassisinghbrar@gmail.com>; linux-kernel at vger.kernel.org;
> > > > Oleksij Rempel <o.rempel@pengutronix.de>; dl-linux-imx
> > > > <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > > > <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > > > > This is used for i.MX multi core communication.
> > > > > e.g. A core to SCU firmware(M core) on MX8.
> > > > >
> > > > > Tx is using polling mode while Rx is interrupt driven and schedule
> > > > > a hrtimer to receive remain words if have more than
> > > > > 4 words.
> > > >
> > > > You told us that using interrupts is not possible due to miserable
> > > > performance, we then provided you a way with which you could poll.
> > > > Why are you using interrupts now?
> > > >
> > >
> > > Because mailbox framework does not support sync rx now, I think we do
> > > not need to wait for that feature done first as it's independent and
> > > separate features of framework.
> >
> > You can wait forever for this feature, nobody will add it for you. It's up to you
> > to add support for that feature. Who else should add this feature if not you?
> > And when will you add that feature if not now when you actually need it?
> > It is common practice that you adjust the frameworks to your needs rather
> > than working around them.
> >
>
> I'm willing to add it. Just because you said Jassi already had the idea on how to
> Implement it and does not add much complexity. So I just want to see his patches.
> But if he did not work on it, I can also help on it.
>
I am not much aware of the history of this conversation... but it
seems you need to make use of mbox_chan_ops.peek_data().

If not that, please let me know the requirement.

Cheers!
