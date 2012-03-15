From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 15 Mar 2012 11:05:09 +0800
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20120314194123.GR26642@pengutronix.de>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120314194123.GR26642@pengutronix.de>
Message-ID: <20120315030508.GC13022@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 03:41:23AM +0800, Sascha Hauer wrote:
> On Tue, Mar 13, 2012 at 04:47:04PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This patch includes basic dt support which can boot via nfs rootfs.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt |    4 +
> >  arch/arm/boot/dts/imx28-evk.dts               |   31 +++++++++
> >  arch/arm/boot/dts/imx28.dtsi                  |   88 +++++++++++++++++++++++++
> >  arch/arm/mach-mxs/Kconfig                     |    9 +++
> >  arch/arm/mach-mxs/Makefile                    |    1 +
> >  arch/arm/mach-mxs/imx28-dt.c                  |   67 +++++++++++++++++++
> >  6 files changed, 200 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 54bddda..9f21faf 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -1,6 +1,10 @@
> 
> > +
> > +static const char *imx28_dt_compat[] __initdata = {
> > +	"fsl,imx28-evk",
> > +	NULL,
> > +};
> > +
> 
> I suggest to add a generic "fsl,imx28" entry here. It helps people to
> start an unpatched kernel on their boards.
> 
Good point.
Thanks for reminder.

Regards
Dong Aisheng
