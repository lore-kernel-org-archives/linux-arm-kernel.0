From: fugang.duan@nxp.com (Fugang Duan)
Date: Tue, 7 Jun 2016 01:40:31 +0000
Subject: [PATCH v2 1/2] ARM: imx6: disable deeper idle states when FEC is
 active w/o HW workaround
In-Reply-To: <87a8iypoib.fsf@gmail.com>
References: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
 <VI1PR0401MB1855AA40FA576AF677A68E6FFF5C0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <87a8iypoib.fsf@gmail.com>
Message-ID: <VI1PR0401MB1855A6AE5F80BB73579D7093FF5D0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Holger Schurig <holgerschurig@gmail.com> Sent: Monday, June 06, 2016 7:04 PM
> To: Fugang Duan <fugang.duan@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de; patchwork-
> lst at pengutronix.de
> Subject: RE: [PATCH v2 1/2] ARM: imx6: disable deeper idle states when FEC is
> active w/o HW workaround
> 
> > You just config the gpio irq like below patches:
> > bc20a5d6da71 (ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC
> > interrupt.) 6261c4c8f13e (ARM: dts: imx6qdl-sabrelite: use GPIO_6 for
> > FEC interrupt.)
> 
> But this is per-board, e.g. not board-agnostic??!?!   Some board might
> have uses GPIO6 for other things and rendered it unusable for this ...

NXP HW reference design guide include this that reserve GPIO6 for FEC.  

The patch is fine for me, but I think it is unnecessary. 
