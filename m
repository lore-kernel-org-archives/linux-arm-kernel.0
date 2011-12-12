From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 14:08:33 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212054857.GB16350@b20223-02.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
 <20111212054857.GB16350@b20223-02.ap.freescale.net>
Message-ID: <20111212060832.GF9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 01:50:10PM +0800, Richard Zhao wrote:
> On Mon, Dec 12, 2011 at 01:40:54PM +0800, Shawn Guo wrote:
> > On Mon, Dec 12, 2011 at 11:42:26AM +0800, Richard Zhao wrote:
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/imx6q-sabrelite.dts |   54 +++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/mach-imx6q.c        |    1 +
> > >  2 files changed, 55 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > new file mode 100644
> > > index 0000000..d54363f
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > @@ -0,0 +1,54 @@
> > > +/*
> > > + * Copyright 2011 Freescale Semiconductor, Inc.
> > > + * Copyright 2011 Linaro Ltd.
> > > + *
> > > + * The code contained herein is licensed under the GNU General Public
> > > + * License. You may obtain a copy of the GNU General Public License
> > > + * Version 2 or later at the following locations:
> > > + *
> > > + * http://www.opensource.org/licenses/gpl-license.html
> > > + * http://www.gnu.org/copyleft/gpl.html
> > > + */
> > > +
> > > +/dts-v1/;
> > > +/include/ "imx6q.dtsi"
> > > +
> > > +/ {
> > > +	model = "Freescale i.MX6 Quad SABRE Lite Board";
> > > +	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> > > +
> > > +	chosen {
> > > +		bootargs = "console=ttymxc1,115200";
> > > +	};
> > > +
> > Maybe we can start dropping this, since kernel is now able to get
> > bootargs from atags even in case that bootloader can not pass dtb
> > and the dtb is appended to kernel image.
> kernel has a config "Extend bootloader kernel arguments". Does it help
> such case?

CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT

-- 
Regards,
Shawn
