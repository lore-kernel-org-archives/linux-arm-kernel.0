From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 10:08:51 +0800
Subject: [RFC PATCH v3 3/5] pinctrl: imx: add pinctrl imx driver
In-Reply-To: <20120108130542.GC2203@richard-laptop>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-4-git-send-email-b29396@freescale.com>
 <20120108130542.GC2203@richard-laptop>
Message-ID: <20120109020848.GF1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 09:05:44PM +0800, Richard Zhao wrote:
> > +enum imx_imx53_pinctrl_pads {
> > +	MX53_GPIO_19 = 0,
> > +	MX53_KEY_COL0 = 1,
> > +	MX53_KEY_ROW0 = 2,
> > +	MX53_KEY_COL1 = 3,
> > +	MX53_KEY_ROW1 = 4,
> > +	MX53_KEY_COL2 = 5,
> > +	MX53_KEY_ROW2 = 6,
> ...
> Why not describe it in dts and make this file generic for imx?
> One node for one pad,

Doing this will bloat the device tree dramatically.  Actually I had
a patch doing so before the pinctrl subsystem was born, but it
concerned Grant a lot for that reason and thus died.

> it'll be easy to extend pad properties. You know
> the pad may set pull up/down, open drain, drive strenth, daisy chain etc.
> The features have to be supported, to make your model usefull.
> 
As Aisheng mentioned, the pinconf support will be added later.

-- 
Regards,
Shawn
