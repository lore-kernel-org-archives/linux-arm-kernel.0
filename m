From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 22 Jan 2018 18:50:21 +0100
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <CAK8P3a0Yq1WuUYih6WKbbjoGRwq-rCQ8OEpuyu0=-SOVV2MNLg@mail.gmail.com>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
 <20180122144729.GA27764@dragon>
 <CAK8P3a0Yq1WuUYih6WKbbjoGRwq-rCQ8OEpuyu0=-SOVV2MNLg@mail.gmail.com>
Message-ID: <1516643421.25726.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 22.01.2018, 16:11 +0100 schrieb Arnd Bergmann:
> On Mon, Jan 22, 2018 at 3:47 PM, Shawn Guo <shawnguo@kernel.org>
> wrote:
> > On Wed, Jan 17, 2018 at 07:32:42PM +0100, Lucas Stach wrote:
> > > This adds the basic DTS for the i.MX8MQ.
> > > For now only the following peripherals are supported:
> > > - IOMUXC (pin controller)
> > > - CCM (clock controller)
> > > - GPIO
> > > - UART
> > > - uSDHC (SD/eMMC controller)
> > > - FEC (ethernet controller)
> > > - i2c
> > > 
> > > This is enough to get a very basic board support up and running.
> > > 
> > > One known limitation is that the driver for the GPC interrupt
> > > controller is still missing, rendering the CPU sleep states
> > > unusable
> > > as there is nothing waking them up anymore. This will be fixed in
> > > due course.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > ?arch/arm64/boot/dts/Makefile?????????????|???1 +
> > > ?arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h | 632
> > > +++++++++++++++++++++++++++++++
> > > ?arch/arm64/boot/dts/nxp/imx8mq.dtsi??????| 418
> > > ++++++++++++++++++++
> > 
> > So we will have the following two folders for SoCs from the same
> > company.
> > 
> > ?arch/arm64/boot/dts/nxp/
> > ?arch/arm64/boot/dts/freescale/
> 
> It might get worse once the sale to Qualcomm goes through and maybe
> if
> Broadcom makes another bid for Qualcomm in a few years ;-)
> 
> > I'm a bit uncomfortable with that.??@Arnd, do you have an opinion
> > how we
> > should handle them?
> 
> It's a recurring problem of course. I have a small preference for
> just adding
> the i.mx files to arch/arm64/boot/dts/freescale/, but I'd leave it up
> to you.

The nice thing about the split into Freescale/NXP is that it nicely
separates the Layerscape and i.MX stuff, which are two quite different
architectures. But that's just a nice coincidence and I'll happily
rework the patches to whatever suits the maintainers most. Please make
a judgement call.

Regards,
Lucas
