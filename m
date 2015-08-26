From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Wed, 26 Aug 2015 09:19:24 +0800
Subject: [PATCH V1 0/3] fix clock issue for fsl,spdif
In-Reply-To: <20150825184527.31346.52324@quantum>
References: <cover.1439284957.git.shengjiu.wang@freescale.com>
 <20150825184527.31346.52324@quantum>
Message-ID: <20150826011922.GA9708@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 11:45:27AM -0700, Michael Turquette wrote:
> Quoting Shengjiu Wang (2015-08-11 02:26:51)
> > fix clock issue for fsl,spdif
> > 
> > Shengjiu Wang (3):
> >   ARM: imx6q: Add SPDIF_GCLK clock in clock tree
> >   ARM: imx6sl: Add SPDIF_GCLK clock in clock tree
> >   ARM: imx6sx: Add SPDIF_GCLK clock in clock tree
> 
> Hello Shengjiu Wang,
> 
> Please move the dts changes into separate patches. I can take the
> changes to the clock driver and the header through the clk tree, but the
> dt patches need to go through arm-soc.
> 
> Regards,
> Mike

Thanks Mike. I will send another patches for dts changes.

> 
> > 
> >  arch/arm/boot/dts/imx6qdl.dtsi            |  2 +-
> >  arch/arm/boot/dts/imx6sl.dtsi             | 16 ++++++++++++++++
> >  arch/arm/boot/dts/imx6sx.dtsi             |  2 +-
> >  drivers/clk/imx/clk-imx6q.c               |  4 +++-
> >  drivers/clk/imx/clk-imx6sl.c              |  4 +++-
> >  drivers/clk/imx/clk-imx6sx.c              |  1 +
> >  include/dt-bindings/clock/imx6qdl-clock.h |  3 ++-
> >  include/dt-bindings/clock/imx6sl-clock.h  |  3 ++-
> >  include/dt-bindings/clock/imx6sx-clock.h  |  3 ++-
> >  9 files changed, 31 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
