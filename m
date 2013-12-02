From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Dec 2013 13:43:48 +0000
Subject: [PATCH v3 36/36] ARM: STi: Add support for the FSM Serial Flash
 Controller
In-Reply-To: <529C8A99.1020204@st.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-37-git-send-email-lee.jones@linaro.org>
 <529C858B.1040601@st.com> <20131202132013.GF31626@lee--X1>
 <529C8A99.1020204@st.com>
Message-ID: <20131202134348.GG31626@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Dec 2013, srinivas kandagatla wrote:

> On 02/12/13 13:20, Lee Jones wrote:
> >>> +		/* FSM */
> >>> +		spifsm: spifsm at fe902000{
> >>> +		        compatible         = "st,spi-fsm", "simple-bus";
> >> "simple-bus" is redundant here.
> > 
> > Yes I agree, good spot.
> > 
> > I removed it from the Documentation, but missed this one.
> > 
> > If I remove it, can I add your Ack for the remainder of the patch?
> Yes,
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> You should be aware that arch/arm/boot/dts/stih416-b2105.dts is not in
> mainline yet.

Yes, I am aware of this. Are you queuing patches for it?

> >>> +		        reg                =  <0xfe902000 0x1000>;
> >>> +		        reg-names          = "spi-fsm";
> >>> +		        pinctrl-0          = <&pinctrl_fsm>;
> >>> +
> >>> +			st,syscfg	   = <&syscfg_rear>;
> >>> +		        st,boot-device-reg = <0x958>;
> >>> +		        st,boot-device-spi = <0x1a>;
> >>> +
> >>> +		        status = "okay";
> >>> +		};
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
