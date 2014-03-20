From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 15:51:19 +0000
Subject: [PATCH v6 36/36] ARM: STi: Add support for the FSM Serial Flash
 Controller
In-Reply-To: <20140320112703.GS31517@norris-Latitude-E6410>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
 <1395307268-12721-37-git-send-email-lee.jones@linaro.org>
 <20140320112703.GS31517@norris-Latitude-E6410>
Message-ID: <20140320155119.GG8207@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Here we add the necessary device nodes required for successful device
> > probing and Pinctrl setup for the FSM.
> > 
> > Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> > Acked-by Angus Clark <angus.clark@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih416-pinctrl.dtsi | 13 +++++++++++++
> >  arch/arm/boot/dts/stih416.dtsi         | 13 +++++++++++++
> >  arch/arm/boot/dts/stih41x-b2020.dtsi   |  1 +
> >  arch/arm/boot/dts/stih41x-b2020x.dtsi  | 28 ++++++++++++++++++++++++++++
> >  4 files changed, 55 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/stih41x-b2020x.dtsi

[...]

> > +	soc {
> > +		spifsm: spifsm at fe902000 {
> > +			#address-cells = <1>;
> > +			#size-cells    = <1>;
> > +
> > +			status = "okay";
> > +
> > +			partition at 0 {
> > +				label = "Serial Flash 1";
> 
> Are you sure you want spaces in the partition label? I suppose MTD can
> probably handle this fine, but it doesn't seem standard, and it may
> prevent you from using the partition name in certain ways. For instance,
> it might make it harder to use with the "ubi.mtd=" module parameter.
> 
> But otherwise:
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>

Code fixed and Ack applied.

Thanks Brian.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
