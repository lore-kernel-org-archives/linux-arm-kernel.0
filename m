From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Dec 2013 13:20:13 +0000
Subject: [PATCH v3 36/36] ARM: STi: Add support for the FSM Serial Flash
 Controller
In-Reply-To: <529C858B.1040601@st.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-37-git-send-email-lee.jones@linaro.org>
 <529C858B.1040601@st.com>
Message-ID: <20131202132013.GF31626@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +		/* FSM */
> > +		spifsm: spifsm at fe902000{
> > +		        compatible         = "st,spi-fsm", "simple-bus";
> "simple-bus" is redundant here.

Yes I agree, good spot.

I removed it from the Documentation, but missed this one.

If I remove it, can I add your Ack for the remainder of the patch?

> > +		        reg                =  <0xfe902000 0x1000>;
> > +		        reg-names          = "spi-fsm";
> > +		        pinctrl-0          = <&pinctrl_fsm>;
> > +
> > +			st,syscfg	   = <&syscfg_rear>;
> > +		        st,boot-device-reg = <0x958>;
> > +		        st,boot-device-spi = <0x1a>;
> > +
> > +		        status = "okay";
> > +		};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
