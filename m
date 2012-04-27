From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 15:16:55 +0800
Subject: [PATCH v3 3/4] pinctrl: pinctrl-imx: add imx6q pinctrl driver
In-Reply-To: <20120427064519.GO17184@pengutronix.de>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-3-git-send-email-b29396@freescale.com>
 <20120427064519.GO17184@pengutronix.de>
Message-ID: <20120427071654.GB826@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 02:45:19PM +0800, Sascha Hauer wrote:
> On Thu, Apr 26, 2012 at 10:40:26PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> > ChangeLog v1-v2:
> > * add binding doc for pinctrl-imx6q
> > * refactor the probe
> > ---
> >  .../bindings/pinctrl/fsl,imx6q-pinctrl.txt         | 1605 ++++++++++++++
> >  drivers/pinctrl/Kconfig                            |    8 +
> >  drivers/pinctrl/Makefile                           |    1 +
> >  drivers/pinctrl/pinctrl-imx6q.c                    | 2331 ++++++++++++++++++++
> >  4 files changed, 3945 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> >  create mode 100644 drivers/pinctrl/pinctrl-imx6q.c
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> > new file mode 100644
> > index 0000000..13d474f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> > @@ -0,0 +1,1605 @@
> > +* Freescale IMX6Q IOMUX Controller
> > +
> > +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> > +and usage.
> > +
> > +Required properties:
> > +- compatible: "fsl,imx6q-iomuxc"
> > +- fsl,pins: two integers array, represents a group of pins mux and config
> > +  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
> > +  pin working on a specific function, CONFIG is the pad setting value like
> > +  pull-up for this pin. Please refer to imx6q datasheet for the valid pad
> > +  config settings.
> 
> Wouldn't it make sense to document the CONFIG bits here? Something like
> 
> Pull keeper enabled (pke)	(1 << 7)
> ...
> 
Yes, it makes sense for me to add it.

> Not all bits are available on all pins, refer to the datasheet...
> 

Regards
Dong Aisheng
