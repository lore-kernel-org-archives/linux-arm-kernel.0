From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 19 Feb 2018 23:13:28 +0530
Subject: [PATCH 06/10] arm64: dts: actions: Add S900 gpio nodes
In-Reply-To: <fb5f904e-a262-df5b-a947-957e579ec4c9@suse.de>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-7-manivannan.sadhasivam@linaro.org>
 <fb5f904e-a262-df5b-a947-957e579ec4c9@suse.de>
Message-ID: <20180219174328.lcrzbj6oswvmaxmt@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Sat, Feb 17, 2018 at 10:08:37PM +0100, Andreas F?rber wrote:
> Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> > Add gpio nodes for Actions Semi S900 SoC.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/actions/s900.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
> > index 0156483f0f4d..e359509ad9d3 100644
> > --- a/arch/arm64/boot/dts/actions/s900.dtsi
> > +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> > @@ -180,6 +180,13 @@
> >  			clocks = <&cmu CLK_GPIO>;
> >  		};
> >  
> > +		gpio: gpio at e01b0000 {
> > +			compatible = "actions,s900-gpio";
> > +			reg = <0x0 0xe01b0000 0x0 0x1000>;
> > +			gpio-controller;
> 
> Same as the bindings example, this is lacking gpio-ranges.
>
Sure, will add it.
> https://github.com/afaerber/linux/commit/f4526bbacd75d014a69e6e3ff051638589ee71a3
> 
> Also why have only one node? That forces the information about GPIO
> banks into the driver rather than into the DT.
> 
In next revision all banks will be made as individual gpio-controllers,
which will in turn have individual nodes. The justification was already
provided in gpio driver patch.

Thanks,
Mani
> > +			#gpio-cells = <2>;
> > +		};
> > +
> >  		timer: timer at e0228000 {
> >  			compatible = "actions,s900-timer";
> >  			reg = <0x0 0xe0228000 0x0 0x8000>;
> 
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
