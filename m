From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Sep 2018 08:33:58 +0200
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
 <20180919194100.GQ4097@pengutronix.de>
 <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180920063358.GS4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 02:27:00AM +0000, A.s. Dong wrote:
> Hi Sasha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Thursday, September 20, 2018 3:41 AM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> > <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo at kernel.org
> > Subject: Re: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
> > 
> > Hi Dong,
> > 
> > Looks mostly ok for me now. Some small things inside.
> > 
> 
> Great, thanks for the keeping review.
> 
> > On Wed, Sep 19, 2018 at 11:04:05AM +0800, Dong Aisheng wrote:
> > > The System Controller Firmware (SCFW) is a low-level system function
> > > which runs on a dedicated Cortex-M core to provide power, clock, and
> > > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > > (QM, QP), and i.MX8QX (QXP, DX).
> > >
> > > This patch implements the SCU firmware IPC function and the common
> > > message sending API sc_call_rpc.
> > >
> > > +int sc_ipc_get_handle(struct sc_ipc *ipc) {
> > > +	if (!scu_ipc_handle)
> > > +		return -EPROBE_DEFER;
> > > +
> > > +	ipc = scu_ipc_handle;
> > 
> > You are modifying a local pointer here instead of returning it.
> > 
> 
> My bad mistake.
> It should be:
> int sc_ipc_get_handle(struct sc_ipc **ipc)
> {
>         if (!scu_ipc_handle)
>                 return -EPROBE_DEFER;
> 
>         *ipc = scu_ipc_handle;
>         return 0;
> }
> 
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(sc_ipc_get_handle);
> > 
> > Could you give the exported functions a better namespace like imx_scu_*?
> > 
> 
> Good idea.
> Should we change all the rest as well?

You mean enums and such? Yes, that would be good.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
