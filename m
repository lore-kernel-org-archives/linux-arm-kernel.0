From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Oct 2017 09:46:41 -0700
Subject: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
In-Reply-To: <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
Message-ID: <20171013164640.GI4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [171011 08:56]:
> On 09/30/2017 01:34 AM, Tony Lindgren wrote:
> > +		target-module at 40128000 {
> > +			compatible = "ti,sysc-mcasp";
> > +			ti,hwmods = "mcasp";
> > +			reg = <0x40128004 0x4>;
> > +			reg-names = "sysc";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x00000000 0x40128000 0x1000>, /* MPU */
> > +				 <0x49028000 0x49028000 0x1000>; /* L3 */
> > +
> > +			/*
> > +			 * Child device unsupported by davinci-mcasp. At least
> > +			 * TX path is disabled for omap4, and only DIT mode
> 
> s/TX/RX
> 
> > +			 * works with no I2S. See also old Android kernel
> > +			 * omap-mcasp driver for more information.

Below is a fix for the RX comment.

Regards,

Tony

8< ------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 13 Oct 2017 09:43:22 -0700
Subject: [PATCH] ARM: dts: Fix typo for omap4 mcasp rx path

As reported by Peter Ujfalusi <peter.ujfalusi@ti.com>, the rx path on macsp
is disabled and only tx is usable if the davinci-mcasp driver is updated for
it.

Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -828,7 +828,7 @@
 
 			/*
 			 * Child device unsupported by davinci-mcasp. At least
-			 * TX path is disabled for omap4, and only DIT mode
+			 * RX path is disabled for omap4, and only DIT mode
 			 * works with no I2S. See also old Android kernel
 			 * omap-mcasp driver for more information.
 			 */
-- 
2.14.2
