From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 16 Jan 2014 15:20:48 -0800
Subject: [PATCH v2 1/2] i2c: qup: Add device tree bindings information
In-Reply-To: <1389689841.2794.8.camel@iivanov-dev.int.mm-sol.com>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389659437-16406-2-git-send-email-bjorn.andersson@sonymobile.com>
 <1389689841.2794.8.camel@iivanov-dev.int.mm-sol.com>
Message-ID: <20140116232047.GK30911@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 14 Jan 00:57 PST 2014, Ivan T. Ivanov wrote:

> 
> Thanks Bjorn, 
> 
> I have prepared second version, but never send it out :-).
> One thing suggested by Mark was missed in this version.

Yeah, Mattew told me you we're assigned to other things and asked me to send
out an update as I had gotten it to work on our boards.

I did modify the wording of most of these to match how it is written in the
other Qualcomm definitions.

@Mark, would you rather have me change this to your suggested wording?

> 
> 
> On Mon, 2014-01-13 at 16:30 -0800, Bjorn Andersson wrote: 
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > 
[snip]
> > + - clocks: Should contain the core clock and the AHB clock.
> 
> + - clocks: a list of phandle + clock-specifier pairs for each entry in
> +           clock-names
> 

This is in line with how it's written in other drivers, so if the DT
maintainers doesn't disagree I would like to keep phandles out of the
description. This specific line is a verbatime copy of the msm_serial
documentation (same block, different mode)...

> > + - clock-names: Should be "core" for the core clock and "iface" for the
> > +                AHB clock.
> > +
> > + - #address-cells: Should be <1> Address cells for i2c device address
> > + - #size-cells: Should be <0> as i2c addresses have no size component
> > +
> > +Optional properties:
> > + - clock-frequency: Should specify the desired i2c bus clock frequency in Hz,
> > +                    default is 100kHz if omitted.
> > +
> > +Child nodes should conform to i2c bus binding.
> > +
> > +Example:
> > +
> > + i2c2: i2c at f9924000 {
> > + 	compatible = "qcom,i2c-qup";
> > + 	reg = <0xf9924000 0x1000>;
> > + 	interrupts = <0 96 0>;
> > +
> > + 	clocks = <&gcc_blsp1_qup2_i2c_apps_clk>, <&gcc_blsp1_ahb_clk>;
> 
> In the light of the latest patches from Stephen, this could be 
> 
> + 	clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;

Yes, that's exactly what I have in my dts. However as this is just an example
I didn't feel it was worth tainting the documentation with all those capital
letters ;)
So unless DT maintainers disagree I would like to just keep it as an example.

Regards,
Bjorn
