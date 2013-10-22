From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 22 Oct 2013 02:33:04 +0000
Subject: [PATCHv5 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
In-Reply-To: <20131008135654.GB16550@ulmo.nvidia.com>
References: <1380521611-2764-1-git-send-email-Li.Xiubo@freescale.com>
 <1380521611-2764-5-git-send-email-Li.Xiubo@freescale.com>
 <20131008135654.GB16550@ulmo.nvidia.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866FBC@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Pawel, Mark, Stephon, Ian

  Could someone help review and ACK the devicetree binding patch please ?

  Thanks very much!

Best Regards,
Xiubo



> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding at gmail.com]
> Sent: Tuesday, October 08, 2013 9:57 PM
> To: swarren at wwwdotorg.org; ian.campbell at citrix.com; mark.rutland at arm.com;
> pawel.moll at arm.com; rob.herring at calxeda.com
> Cc: Guo Shawn-R65073; s.hauer at pengutronix.de; t.figa at samsung.com;
> grant.likely at linaro.org; linux at arm.linux.org.uk; rob at landley.net; linux-
> arm-kernel at lists.infradead.org; linux-pwm at vger.kernel.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-
> doc at vger.kernel.org; Xiubo Li-B47053
> Subject: Re: [PATCHv5 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM.
> 
> On Mon, Sep 30, 2013 at 02:13:31PM +0800, Xiubo Li wrote:
> > This adds the Document for Freescale FTM PWM driver under
> > Documentation/devicetree/bindings/pwm/.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 33
> ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> 
> Can someone of the device tree bindings maintainers review and ACK this?
> I think it'd be good to squash this patch with the driver patch (patch 1
> of this series). I can do that when I apply this.
> 
> Thierry
> 
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> > b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> > new file mode 100644
> > index 0000000..2c6969a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> > @@ -0,0 +1,33 @@
> > +Freescale FTM PWM controller
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,vf610-ftm-pwm"
> > +- reg: Physical base address and length of the controller's registers
> > +- #pwm-cells: Should be 3. See pwm.txt in this directory for a
> > +description of
> > +  the cells format.
> > +- clock-names : Includes the following module clock source entries:
> > +    "ftm0" (system clock),
> > +    "ftm0_fix_sel" (fixed frequency clock),
> > +    "ftm0_ext_sel" (external clock)
> > +- clocks : Must contain a clock specifier for each entry in clock-
> names.
> > +- fsl,pwm-counter-clk: The FTM PWM counter clock source, should be
> > +one of the
> > +  entries in clock-names.
> > +- pinctrl-names: must contain a "default" entry.
> > +- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
> > +  See ../pinctrl/pinctrl-bindings.txt for details of the property
> values.
> > +
> > +
> > +Example:
> > +
> > +pwm0: pwm at 40038000 {
> > +		compatible = "fsl,vf610-ftm-pwm";
> > +		reg = <0x40038000 0x1000>;
> > +		#pwm-cells = <3>;
> > +		clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
> > +		clocks = <&clks VF610_CLK_FTM0>,
> > +			<&clks VF610_CLK_FTM0_FIX_SEL>,
> > +			<&clks VF610_CLK_FTM0_EXT_SEL>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_pwm0_1>;
> > +		fsl,pwm-counter-clk = "ftm0_ext_sel"; };
> > --
> > 1.8.0
> >
> >
