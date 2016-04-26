From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 Apr 2016 18:35:58 +0100
Subject: [[PATCH v2] 1/8] ARM: dts: STi: STiH407: Provide generic (safe)
 DVFS configuration
In-Reply-To: <571F76AF.6040808@st.com>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
 <571F76AF.6040808@st.com>
Message-ID: <20160426173558.GB4892@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Apr 2016, Maxime Coquelin wrote:

> Hi Lee,
> 
>     Series is applied, thanks for having done the changes.
> 
>     Note that I had to rework all the commit titles, because of the double
> brackets ("[[PATCH v2] 1/8]").
>     Something wrong with your script?

Apologies.  Nothing wrong with the script, this was a manual error
that I didn't catch until after they'd been sent.  Problem was

  `git format-patch $sha..HEAD --subject-prefix="[PATCH v2]"`

... I should have omitted the '[]'s, since gfp does this for you.

> On 04/21/2016 05:07 PM, Lee Jones wrote:
> >You'll notice that the voltage cell is populated with 0's.  Voltage
> >information is very platform specific, even depends on 'cut' and
> >'substrate' versions.  Thus it is left blank for a generic (safe)
> >implementation.  If other nodes/properties are provided by the
> >bootloader, the ST CPUFreq driver will over-ride these generic
> >values.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> >---
> >  arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> >index 81f8121..9fa1e58 100644
> >--- a/arch/arm/boot/dts/stih407-family.dtsi
> >+++ b/arch/arm/boot/dts/stih407-family.dtsi
> >@@ -22,15 +22,29 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a9";
> >  			reg = <0>;
> >+
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr = <0x94100A4>;
> >+
> >+					 /* kHz     uV   */
> >+			operating-points = <1500000 0
> >+					    1200000 0
> >+					    800000  0
> >+					    500000  0>;
> >  		};
> >  		cpu at 1 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a9";
> >  			reg = <1>;
> >+
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr = <0x94100A4>;
> >+
> >+					 /* kHz     uV   */
> >+			operating-points = <1500000 0
> >+					    1200000 0
> >+					    800000  0
> >+					    500000  0>;
> >  		};
> >  	};
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
