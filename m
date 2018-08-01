From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 1 Aug 2018 07:44:43 +0000
Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CABb+yY2PN=LN3bgTTzL9SpA43atughAbS1OjNsg0XZg42JxD3w@mail.gmail.com>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-5-o.rempel@pengutronix.de>
 <CABb+yY2PN=LN3bgTTzL9SpA43atughAbS1OjNsg0XZg42JxD3w@mail.gmail.com>
Message-ID: <AM0PR04MB42118C26A7C5F80FD46FBB9B802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]

[...]

> > +
> > +static void imx_mu_txdb_work(struct work_struct *work) {
> > +       struct imx_mu_con_priv *cp =
> > +                       container_of(work, struct imx_mu_con_priv, work);
> > +       mbox_chan_txdone(cp->chan, 0); }
> >
> The api assumes a controller have same type of channels. So we are having
> to do this here.
> I am not sure, but would declaring two mailbox controllers (one with
> doorbells and the other data channels) work?
> If not, at least we could use a tasklet instead of a work queue?
> 

I'm also a bit curious what the meaning of calling mbox_chan_txdone
for a doorbell mailbox?

Is there any recommended way to use it?

Regards
Dong Aisheng
