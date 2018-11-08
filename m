From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 8 Nov 2018 02:30:53 +0000
Subject: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
In-Reply-To: <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
 <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
Message-ID: <DB3PR0402MB3916B027A9C724D349C7969EF5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Best Regards!
Anson Huang

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2018?11?8? 10:21
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>;
> Fabio Estevam <fabio.estevam@nxp.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
> 
> Hi Anson,
> 
> On Wed, Nov 7, 2018 at 11:24 PM Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > Regarding the fec2 settings in imx7d-sdb.dts, originally it uses Rev-A
> > board (but some nodes are using Rev-B board), in this patch, I clean
> > up all the settings in imx7d-sdb.dts using Rev-B board, so below is
> > added to imx7d-sdb.dts for Rev-B board, and in imx7d-sdb-reva.dts I have to
> delete it, since Rev-A board has no this pin.
> >
> > -       pinctrl-0 = <&pinctrl_enet2>;
> > +       pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_epdc0_en>;
> > +       pinctrl-assert-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> 
> "pinctrl-assert-gpios" only exists in the NXP vendor kernel, so you cannot use
> such property in mainline.

Thanks for pointing out this issue, I made a mistake when doing the search in git repo..
So, if we have to assert a GPIO, there is no common way in pinctrl driver? Have to
do it in driver itself? Like this case, we have to assert the GPIO in fec driver?

Or, by default the GPIO is LOW on the board which is for FEC2, we can just skip it now?
The EPDC driver is NOT enabled yet in upstream mainline.

Anson.
