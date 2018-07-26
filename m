From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 26 Jul 2018 13:34:34 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY3OdXGair6hdLH_jb54O09y=rhUMfbG1-LSa=pHvDz+sQ@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY3OdXGair6hdLH_jb54O09y=rhUMfbG1-LSa=pHvDz+sQ@mail.gmail.com>
Message-ID: <AM0PR04MB4211928BCBB743EBB93E285D802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, July 26, 2018 8:27 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; , Sascha Hauer
> <kernel@pengutronix.de>; , linux-arm-kernel at lists.infradead.org, linux-
> mediatek at lists.infradead.org, srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; Devicetree List <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support

[...]

> > And SCU firmware does use MU in above way specified by reference
> manual.
> > Even from HW point of view, it's still one channel only mailbox.
> > That's why we change the mbox-cells to 0 accordingly to avoid
> > confusing the multi channels users supported in this driver.
> >
> > As per Sasha's request, we're going to support both protocol (SCU and
> > generic M4) in one mailbox driver, that means we need deal with this two
> case property.
> >
> > If we use mbox-cells 1 case for SCU, then the using would be like:
> > mboxes = <&mailbox 0> which is mixed with the normal multi channel
> > users. And we also must state clearly in binding doc that for
> > mbox-cells
> >  1 case for SCU, the cell value must be 0 which is also confusing with
> > Multi channel users.
> >
> > How do you suggest for such case?
> >
> Let me read the spec and try to see/shine the light :)

Great, many thanks!

Regards
Dong Aisheng

> 
> Cheers!
