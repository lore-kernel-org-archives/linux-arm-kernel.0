From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 20:20:33 +0800
Subject: [PATCH 3/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
In-Reply-To: <AM3PR04MB3069C90F23CF9C9CC84BA7580E10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-5-git-send-email-aisheng.dong@nxp.com>
 <20170515114319.GP8471@dragon>
 <AM3PR04MB3069C90F23CF9C9CC84BA7580E10@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170515122032.GS8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 12:06:19PM +0000, A.S. Dong wrote:
> > > @@ -0,0 +1,56 @@
> > > +* Freescale i.MX7ULP IOMUX Controller
> > > +
> > > +Please refer to fsl,imx-pinctrl.txt in this directory for common
> > > +binding part and usage.
> > 
> > Are imx7ulp-pinctrl bindings more alike to fsl,imx-pinctrl.txt or generic
> > pinctrl-bindings.txt?  My personal feeling is that it might be better to
> > take pinctrl-bindings.txt as the reference base and highlight how imx7ulp-
> > pinctrl bindings differ from it.
> > 
> 
> It seems still more like fsl,imx-pinctrl.txt.
> 
> I know fsl,imx-pinctrl.txt is a bit out of date, especially after we add
> generic pinconf.
> 
> I plan to update it later after adding generic pin conf support to legacy
> SoCs (MX6 & 7) as well, do you think it's ok?

Please do not.  Let's use generic pinconf support only for new SoCs, and
not bother with legacy SoCs.

<snip>

> > > diff --git a/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h
> > > b/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h
> > > new file mode 100644
> > > index 0000000..b6db73f
> > > --- /dev/null
> > > +++ b/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h
> > 
> > The header will only be used by dts files, right?  If so,
> > arch/arm/boot/dts is the better place.
> > 
> 
> I can do it, but I'm just a bit confused that only IMX is still
> Putting pinctrl headfile under arch/arm/boot/dts/.

It makes sense to define DT constants in include/dt-bindings/pinctrl/
only when they are referenced by both kernel and dts.  If it's only
included by dts, arch/arm/boot/dts/ should definitely be the better
place.

Shawn
