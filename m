From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 1 Sep 2015 10:11:37 +0100
Subject: [STLinux Kernel] [PATCH v2 1/4] ARM: STiH407: Add nodes for
 RemoteProc
In-Reply-To: <20150901082812.GB30542@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-2-git-send-email-lee.jones@linaro.org>
 <20150901082812.GB30542@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150901091137.GN4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Sep 2015, Peter Griffin wrote:
> On Fri, 28 Aug 2015, Lee Jones wrote:
> 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 48 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 33daa49..89a363c 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -608,5 +608,53 @@
> >  			status		= "okay";
> >  			tx-only;
> >  		};
> > +
> > +		st231_gp0: st231-gp0 at 0 {
> > +			compatible = "st,st231-rproc";
> > +			reg = <0x40000000 0x01000000>;
> > +			reg-names = "carveout";
> > +			resets = <&softreset STIH407_ST231_GP0_SOFTRESET>;
> 
> Support for these co-processor reset lines does not exist upstream. So
> this series as it stands won't compile.

That's true.  I have the support as part of some DEBUG patches I have
in my branch.  Are you aware of a plan for these, or should I upstream
them myself as part of this set?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
