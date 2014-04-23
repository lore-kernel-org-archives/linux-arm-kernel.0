From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Apr 2014 07:48:22 -0700
Subject: [PATCH RFC] ARM: dts: am335x: update USB DT references
In-Reply-To: <5356794C.7070707@baylibre.com>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
 <5356794C.7070707@baylibre.com>
Message-ID: <20140423144822.GA4833@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
> Hi Leigh,
> 
> On 16/04/2014 13:26, Leigh Brown wrote:
> >In "ARM: dts: am33xx: correcting dt node unit address for usb", the
> >usb_ctrl_mod and cppi41dma nodes were updated with the correct register
> >addresses.  However, the dts files that reference these nodes were not
> >updated, and those devices are no longer being enabled.
> >
> >This patch corrects the references for the affected dts files.
> 
> Thanks for the fix. BTW, why is it a RFC? Do you plan to send an updated
> version?
> 
> FYI, even with this fix, the BBB still does not have a working MUSB on
> 3.15-rc2. Have you observed that as well?
> 
> >Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
> 
> If this is a final version, I'll apply it for -rc3.

Looks like I already have this in omap-for-v3.15/fixes-v2, sorry
looks like I never replied to this one.

Regards,

Tony 
 
> >---
> >  arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++--
> >  arch/arm/boot/dts/am335x-evm.dts          | 4 ++--
> >  arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++--
> >  arch/arm/boot/dts/am335x-igep0033.dtsi    | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >index e3f27ec..2e7d932 100644
> >--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> >+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >@@ -183,7 +183,7 @@
> >  &usb {
> >  	status = "okay";
> >
> >-	control at 44e10000 {
> >+	control at 44e10620 {
> >  		status = "okay";
> >  	};
> >
> >@@ -204,7 +204,7 @@
> >  		dr_mode = "host";
> >  	};
> >
> >-	dma-controller at 07402000  {
> >+	dma-controller at 47402000  {
> >  		status = "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> >index 28ae040..77df10d 100644
> >--- a/arch/arm/boot/dts/am335x-evm.dts
> >+++ b/arch/arm/boot/dts/am335x-evm.dts
> >@@ -331,7 +331,7 @@
> >  &usb {
> >  	status = "okay";
> >
> >-	control at 44e10000 {
> >+	control at 44e10620 {
> >  		status = "okay";
> >  	};
> >
> >@@ -352,7 +352,7 @@
> >  		dr_mode = "host";
> >  	};
> >
> >-	dma-controller at 07402000  {
> >+	dma-controller at 47402000  {
> >  		status = "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> >index ec08f6f..ab23885 100644
> >--- a/arch/arm/boot/dts/am335x-evmsk.dts
> >+++ b/arch/arm/boot/dts/am335x-evmsk.dts
> >@@ -364,7 +364,7 @@
> >  &usb {
> >  	status = "okay";
> >
> >-	control at 44e10000 {
> >+	control at 44e10620 {
> >  		status = "okay";
> >  	};
> >
> >@@ -385,7 +385,7 @@
> >  		dr_mode = "host";
> >  	};
> >
> >-	dma-controller at 07402000  {
> >+	dma-controller at 47402000  {
> >  		status = "okay";
> >  	};
> >  };
> >diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
> >index 7063311..5942e7d 100644
> >--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> >+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> >@@ -202,7 +202,7 @@
> >  &usb {
> >  	status = "okay";
> >
> >-	control at 44e10000 {
> >+	control at 44e10620 {
> >  		status = "okay";
> >  	};
> >
> >@@ -223,7 +223,7 @@
> >  		dr_mode = "host";
> >  	};
> >
> >-	dma-controller at 07402000  {
> >+	dma-controller at 47402000  {
> >  		status = "okay";
> >  	};
> >  };
> >
> 
> 
> -- 
> Beno?t Cousson
> BayLibre
> Embedded Linux Technology Lab
> www.baylibre.com
