From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 22:28:56 +0800
Subject: [PATCH 4/5] ARM: dts: imx51-babbage: enable audio support
In-Reply-To: <CAOMZO5Azg9=wZvkut+2d6XtU4zdO6jRiTjxUP+ocmpJWmUSJVA@mail.gmail.com>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-5-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5Azg9=wZvkut+2d6XtU4zdO6jRiTjxUP+ocmpJWmUSJVA@mail.gmail.com>
Message-ID: <20120511142851.GB17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 10:18:13AM -0300, Fabio Estevam wrote:
> Shawn,
> 
> On 5/11/12, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx51-babbage.dts |   28 +++++++++++++++++++++++++++-
> >  arch/arm/boot/dts/imx51.dtsi        |   33
> 
> Looking at the Freescale kernel I see some GPIOs that need to be
> setup, such as audio oscillator enable pin (GPUO4_26), but I don't see
> any audio related GPIO pin in your patch.
> 
Yes, I noticed that.  But it seems to me that the oscillator is enabled
by default anyway, so for now, I treat it as a fixed-rate clock without
gating and have the frequency defined in device tree.

> Will this be added later via pinctrl?
> 
For later, we will probably have another basic clk type supported in
clk framework, fixed-rate clock with a gpio control as the gating.

-- 
Regards,
Shawn
