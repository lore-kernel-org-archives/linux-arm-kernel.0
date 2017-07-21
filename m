From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 13:37:12 -0700
Subject: [PATCH v7 3/3] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <c5264416-754b-6ec8-f9fb-3b0ac2ba3a58@mleia.com>
References: <1500474344-9832-1-git-send-email-gabriel.fernandez@st.com>
 <1500474344-9832-4-git-send-email-gabriel.fernandez@st.com>
 <d999fc79-7b14-da8e-965f-371cf4352dd1@mleia.com>
 <11c37627-a39b-7f2d-d0d4-af312eac8668@st.com>
 <c5264416-754b-6ec8-f9fb-3b0ac2ba3a58@mleia.com>
Message-ID: <20170721203712.GH19878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Vladimir Zapolskiy wrote:
> Hi Gabriel,
> 
> On 07/20/2017 11:31 AM, Gabriel FERNANDEZ wrote:
> > Hi Vladimir,
> > 
> > 
> > On 07/19/2017 11:20 PM, Vladimir Zapolskiy wrote:
> >> Hello Gabriel,
> >>
> >> On 07/19/2017 05:25 PM, gabriel.fernandez at st.com wrote:
> >>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> >>> +
> >>> +	rcc: rcc at 58024400 {
> >> 'rcc' as a generic device node name is awkward.
> >>
> >> I believe the main function of the device is clock controller (unlikely
> >> a generic reset controller can be converted into a clock controller),
> >> the locations of the document and device driver also indicate that
> >> primarily it is a clock controller, so I suggest to replace device node
> >> name with 'clock-controller' like below:
> > I prefer to keep rcc node name, to be coherent with the other ST 
> > platforms (STM32F4/F7)
> 
> the thing is, a device node name is expected to comply with ePAPR or
> the devicetree specification, which says
> 
> 	The name of a node should be somewhat generic, reflecting
> 	the function of the device and not its precise programming model.
> 
> If devicetree and CCF maintainers are fine with 'rcc', I won't object,
> my role is just to emphasize the found issue and recommend to use another
> and more common name 'clock-controller', it is a simple and fortunately
> backward compatible change to other ST platforms as well.

Yes. It should be generic so clock-controller or
clock-reset-controller is appropriate here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
