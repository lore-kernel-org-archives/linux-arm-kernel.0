From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 22 May 2014 14:50:01 +0200
Subject: [PATCH] ARM: socfpga: dts: add watchdog0+1
In-Reply-To: <537DF210.50508@cogentembedded.com>
References: <1400753977-11620-1-git-send-email-s.trumtrar@pengutronix.de>
 <537DF210.50508@cogentembedded.com>
Message-ID: <20140522125001.GK949@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 04:48:16PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-05-2014 14:19, Steffen Trumtrar wrote:
> 
> >The SoCFPGA has two watchdog timers. Add them to the dtsi.
> 
> >Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >---
> >  arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> >index 56fc214..ee10fa6 100644
> >--- a/arch/arm/boot/dts/socfpga.dtsi
> >+++ b/arch/arm/boot/dts/socfpga.dtsi
> >@@ -549,6 +549,22 @@
> [...]
> >+		watchdog1: wd at ffd04000 {
> 
>    Oh, and the unit-address part of the name should match the "reg" property.
> 

Oops. Of course.

> >+			compatible = "snps,dw-wdt";
> >+			reg = <0xffd03000 0x1000>;
> >+			interrupts = <0 172 0>;
> >+			clocks = <&osc1>;
> >+			status = "disabled";
> >+		};
> >+

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
