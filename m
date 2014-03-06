From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 06 Mar 2014 20:33:27 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2OV1bIDYvOF0gc3RhZ2luZzogaW14LWRybTogcGFyYWxs?=
 =?UTF-8?B?ZWwgZGlzcGxheTogYWRkIHJlZ3VsYXRvciBzdXBwb3J0Lg==?=
In-Reply-To: <1394123369.3622.54.camel@paszta.hi.pengutronix.de>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-3-git-send-email-denis@eukrea.com>
 <1394123369.3622.54.camel@paszta.hi.pengutronix.de>
Message-ID: <1394123607.101743380@f103.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????,  6 ????? 2014, 17:29 +01:00 ?? Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Denis,
> 
> Am Donnerstag, den 06.03.2014, 17:04 +0100 schrieb Denis Carikli:
> > diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> > index 2d24425..4dd7ce5 100644
> > --- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> > +++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> > @@ -28,6 +28,7 @@ Required properties:
> >  - compatible: Should be "fsl,imx-parallel-display"
> >  - crtc: the crtc this display is connected to, see below
> >  Optional properties:
> > +- display-supply : phandle to the regulator device tree node if needed.
> 
> I'd very much prefer to not do this here. I have submitted a patch to
> add drm_display support to this driver, so you can connect a drm_panel
> compatible driver as output. The simple-panel driver already supports
> supply regulator and backlight control.
...
> > +	imxpd->disp_reg = devm_regulator_get(dev, "display");
> > +	if (IS_ERR(imxpd->disp_reg))
> > +		return PTR_ERR(imxpd->disp_reg);

And here we can see that this regulator is not optional.

---
