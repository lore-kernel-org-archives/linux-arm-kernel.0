From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 22 May 2017 12:30:21 +0000
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <CACRpkdb6B-f0uHUo9ecUmGCzY8GfFbCjNtJFeQJqtKEYwyB87A@mail.gmail.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdb6B-f0uHUo9ecUmGCzY8GfFbCjNtJFeQJqtKEYwyB87A@mail.gmail.com>
Message-ID: <AM3PR04MB306C6E7EA4431A773B25CCF80F80@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Monday, May 22, 2017 5:27 PM
> To: A.S. Dong; Jacopo Mondi; Geert Uytterhoeven; Chris Brandt; Andy
> Shevchenko
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Shawn Guo; Stefan Agner; Jacky Bai; Andy Duan; Sascha Hauer; Rob Herring;
> Mark Rutland; devicetree at vger.kernel.org
> Subject: Re: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl
> binding doc
> 
> On Fri, May 19, 2017 at 9:05 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> 
> > i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
> > IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.
> >
> > This patch adds the IOMUXC1 support for A7.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> (...)
> > +=== Pin Configuration Node ===
> > +- pins: One integers array, represents a group of pins mux setting.
> > +       The format is fsl,pins = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin
> working on
> > +       a specific function.
> > +
> > +       NOTE: i.MX7ULP PIN_FUNC_ID consists of 4 integers as it shares
> one mux
> > +       and config register as follows:
> > +       <mux_conf_reg input_reg mux_mode input_val>
> > +
> > +       Refer to imx7ulp-pinfunc.h in in device tree source folder for
> all
> > +       available imx7ulp PIN_FUNC_ID.
> > +
> > +Optional Properties:
> > +- nxp,output-buffer-enable:    Bool. Output buffer enabled
> > +- nxp,input-buffer-enable:     Bool. Input buffer enabled
> > +- drive-strength               Integer. Controls Drive Strength
> > +                                       0: Standard
> > +                                       1: Hi Driver
> (...)
> 
> WELL LOOK AT THAT
> 
> Custom input/output buffer enable properties eh?
> 
> We had this really really long discussion with the Renesas people about
> whether they make this a custom property or a generic one or whether
> anyone else would ever have the same need.
> 
> This would be a vote for adding output-buffer-enable and input-buffer-
> enable as generic properies hm?
> 

Yes, that would be good if they're made generic properties.

> UNLESS the existing device tree properties already cover the usecases.
> 
> Andy has made some good points there.
> 
> Can you please read up on the discussion thread for subject "[PATCH v5
> 01/10] pinctrl: generic: Add bi-directional and output-enable"
> and contribute to this discussion?
> 

Sure, will find time to read it.

Thanks for the reminder.

Regards
Dong Aisheng
