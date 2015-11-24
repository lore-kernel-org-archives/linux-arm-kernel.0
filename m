From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 16:43:29 -0800
Subject: [PATCH 2/4] arm64: dts: Add msm8996 SoC and MTP board support
In-Reply-To: <5652D87D.20201@codeaurora.org>
References: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
 <1447809149-29724-3-git-send-email-sboyd@codeaurora.org>
 <5652D87D.20201@codeaurora.org>
Message-ID: <20151124004329.GJ19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Rajendra Nayak wrote:
> 
> On 11/18/2015 06:42 AM, Stephen Boyd wrote:
> > Add initial device tree support for the Qualcomm MSM8996 SoC and
> > MTP8996 evaluation board.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> []...
> 
> > +
> > +		spmi_bus: qcom,spmi at 400f000 {
> > +			compatible = "qcom,spmi-pmic-arb";
> > +			reg = <0x400f000 0x1000>,
> > +			      <0x4400000 0x800000>,
> > +			      <0x4c00000 0x800000>,
> > +			      <0x5800000 0x200000>,
> > +			      <0x400a000 0x002100>;
> > +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> > +			interrupt-names = "periph_irq";
> > +			interrupts = <GIC_SPI 326 IRQ_TYPE_NONE>;
> > +			qcom,ee = <0>;
> > +			qcom,channel = <0>;
> > +			#address-cells = <2>;
> > +			#size-cells = <0>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <4>;
> > +		};
> > +
> > +		mmcc: clock-controller at 8c0000 {
> > +			compatible = "qcom,mmcc-msm8996";
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			reg = <0x8c0000 0xc0000>;
> 
> I think the size here should be 0x40000 and not 0xc0000
> 

Yes you're right.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
