From: marex@denx.de (Marek Vasut)
Date: Tue, 24 Nov 2015 12:04:55 +0100
Subject: [PATCH V2 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1448270124.3689.2.camel@pengutronix.de>
References: <1447840120-8513-2-git-send-email-marex@denx.de>
 <1448052365-4987-1-git-send-email-marex@denx.de>
 <1448270124.3689.2.camel@pengutronix.de>
Message-ID: <201511241204.55621.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 23, 2015 at 10:15:24 AM, Lucas Stach wrote:
> Am Freitag, den 20.11.2015, 21:46 +0100 schrieb Marek Vasut:
> > From: Sean Cross <xobs@kosagi.com>
> > 
> > Novena is an open-hardware laptop/desktop/bare board.
> > 
> > See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > ---
> > 
> >  arch/arm/boot/dts/Makefile         |   1 +
> >  arch/arm/boot/dts/imx6q-novena.dts | 856
> >  +++++++++++++++++++++++++++++++++++++ 2 files changed, 857
> >  insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
> > 
> > V2: Fix the PCIe regulator, make it always on
> > 
> >     Fix the polarity of SD2 WP and CD lines, make them active low.
> >     Drop the simple-bus for regulators, put them in /soc instead.
> 
> Huh? No. The fixed and GPIO controlled regulators are certainly not part
> of the SoC. They are board level components and belong into the same DT
> hierarchy level as the sound codec and leds.

Huh? When I did that with 4.4rc1, the regulators were not detected, but with
4.4rc2 they are. Must've been some instability at that point of development
cycle. I will test this some more and then send a V3.

Thanks for the help :)

> Otherwise looks good now.
> 
> Regards,
> Lucas

Best regards,
Marek Vasut
