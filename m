From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 3 Sep 2018 08:57:36 +0000
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <AM0PR04MB42110CB29DC190C9163B2FB580090@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42113BB0FA9E54629339F872800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180828062113.khmkvsj3ofc7muu6@pengutronix.de>
 <AM0PR04MB4211A6BC038A141BA25B638A800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180829065346.zi6v6me7ufft7ntt@pengutronix.de>
 <AM0PR04MB42110CB29DC190C9163B2FB580090@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211680A90724E089F5A1468800C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: A.s. Dong
> Sent: Wednesday, August 29, 2018 4:35 PM
> To: Sascha Hauer <s.hauer@pengutronix.de>

[...]

> > > The original point is to separate the SCU service API implementation
> > > from the client drivers. Client drivers don't have to know the
> > > internal details of the API implementation, they just use the
> > > service API provided by SCU firmware. API implementation and client
> > > users will be
> > maintained independently.
> >
> > I would buy this argument if the 'API implementation' was more than a
> > shim layer that directly translates between function arguments and a
> message struct.
> > With this you effectively can't change the API implementation without
> > changing the API you provide to the client drivers.
> >
> 
> In reality, the API implementation could change without changing the API
> prototype.
> The API is defined in a more generic way and less possible to change.
> But the internal implementation is allowed to change if the firmware updates.
> e.g. protocol params layout and size and etc.
> 
> This way give us a clear separation between API internals and client users
> which are more like to be maintained independently.
> And it may also help if we want to support old firmware due to API internal
> implementation changes. (And note that SCU firmware supports many
> functions, distribute them into various drivers may cause a bit mess. Some of
> them may get troubles on finding a proper place to put.)
> 
> So aren't those more valuable comparing to move SCU APIs into client drivers?
> And current kernel users (arm scpi/scmi, ti sci) already do like this... why not
> i.MX?
> 
> Sorry if I still not get your point.
> Please help clarify a bit more if I missed something..

Please let me know if you still believe moving SCU API implementation into
each client driver is a more reasonable way to go, then i will do it as I trust
your professionality.
.
This patch series has been pending for a long time. We need a way out to
speed up the work.

Regards
Dong Aisheng

> 
> Regards
> Dong Aisheng
> 
> > Sascha
> >
> > --
> > Pengutronix e.K.                           |
> > |
> > Industrial Linux Solutions                 |
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> >
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C97
> >
> 6c8b12abfc4be67f0708d60d7c2c1e%7C686ea1d3bc2b4c6fa92cd99c5c30163
> >
> 5%7C0%7C0%7C636711224308904255&amp;sdata=i2OfGviDpZrpEQVVv51gd
> > gu2Cq20aBtRRtzR2wLzr0U%3D&amp;reserved=0  | Peiner Str. 6-8, 31137
> > Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> > +49-5121-206917-5555 |
