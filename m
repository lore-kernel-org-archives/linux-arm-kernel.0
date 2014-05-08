From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 08 May 2014 18:50:32 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gQVJNOiBkdHM6IGlteDY6IGFkZCBuZXcgYm9hcmQg?=
 =?UTF-8?B?UklvVGJvYXJk?=
In-Reply-To: <536B9654.7020509@gmail.com>
References: <53695C34.5000604@gmail.com>
 <CAOMZO5AMf74btETX9zM97B-rCRAVh9-s=N4=xqTMifuucwqURg@mail.gmail.com>
 <536B9654.7020509@gmail.com>
Message-ID: <1399560632.547109991@f294.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 08 May 2014 15:36:04 +0100 ?? Iain Paton <ipaton0@gmail.com>:
> On 08/05/14 14:45, Fabio Estevam wrote:
> > On Thu, May 8, 2014 at 6:13 AM, Iain Paton <ipaton0@gmail.com> wrote:
> >> add element14s RIoTboard http://www.riotboard.org which is an i.MX6Solo
> >> based design targeted at makers.
> >>
> >> Signed-off-by: Iain Paton<ipaton0@gmail.com>
> > 
> > Looks good. One comment only:
> > 
> > 
> >> +&i2c4 {
> >> +       clock-frequency = <100000>;
> >> +       pinctrl-names = "default";
> >> +       pinctrl-0 = <&pinctrl_i2c4>;
> >> +       clocks = <&clks 116>;
> > 
> > You could remove this 'clocks' line.
> > 
> 
> I don't see how.
> 
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/tree/arch/arm/boot/dts/imx6dl.dtsi?h=for-next
> 
> has the definition of i2c4 as
> 
> aips2: aips-bus at 02100000 {
> 	i2c4: i2c at 021f8000 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "fsl,imx1-i2c";
> 		reg = <0x021f8000 0x4000>;
> 		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> 		status = "disabled";
> 	};
> };
> 
> as it has no clocks line I need to add one somewhere otherwise the driver
> won't bind to i2c4. 
> 
> The missing clocks line was something I'd ran into earlier which led to this 
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=for-next&id=22f5176336b4fc859b8b16211bdfe079405a778f
> 
> If it's preferable to put the clocks line in imx6dl.dtsi then I can do 
> it there instead.  
> Seperate patch to be applied before the RIoTboard one would be best?

I think you should make patch series:
1. Add missing clock into imx6dl.dtsi
2. Add label to AIPS2 to imx6qdl.dtsi and use this label in imx6dl.dtsi
3. This patch

---
