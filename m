From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 16:51:43 -0500
Subject: [PATCH v2 1/2] arm: dts: am4372: let boards enable RTC and
 Watchdog
In-Reply-To: <53A20800.3070301@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-2-git-send-email-balbi@ti.com>
 <53A1B677.9010909@ti.com> <20140618192553.GB4570@saruman.home>
 <53A20800.3070301@ti.com>
Message-ID: <20140618215143.GA8181@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 04:43:28PM -0500, Nishanth Menon wrote:
> On 06/18/2014 02:25 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Wed, Jun 18, 2014 at 10:55:35AM -0500, Nishanth Menon wrote:
> >>$subject - ARM: dts:
> >>
> >>On 06/18/2014 10:43 AM, Felipe Balbi wrote:
> >>>by providing phandles to rtc and wdt nodes, we can
> >>>let boards enable rtc and wdt as necessary.
> >>>
> >>>Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>>---
> >>>  arch/arm/boot/dts/am4372.dtsi | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> >>>index 49fa596..e3830d4 100644
> >>>--- a/arch/arm/boot/dts/am4372.dtsi
> >>>+++ b/arch/arm/boot/dts/am4372.dtsi
> >>>@@ -270,7 +270,7 @@
> >>>  			ti,hwmods = "counter_32k";
> >>>  		};
> >>>
> >>>-		rtc at 44e3e000 {
> >>>+		rtc: rtc at 44e3e000 {
> >>>  			compatible = "ti,am4372-rtc","ti,da830-rtc";
> >>>  			reg = <0x44e3e000 0x1000>;
> >>>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
> >>>@@ -279,7 +279,7 @@
> >>>  			status = "disabled";
> >>>  		};
> >>>
> >>>-		wdt at 44e35000 {
> >>>+		wdt: wdt at 44e35000 {
> >>>  			compatible = "ti,am4372-wdt","ti,omap3-wdt";
> >>>  			reg = <0x44e35000 0x1000>;
> >>>  			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> >>>
> >>we might want to fix up any other similar nodes in dtsi as well, no?
> >>
> >>examples:
> >>cpu at 0
> >
> >and why would you want boards to mess with the cpu node ?
> >
> cpu-supply = <&regulator>;
> 
> for cpufreq.

good point, but does thqt even work with AM437x devices in mainline?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/8a93ac93/attachment-0001.sig>
