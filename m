From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Dec 2015 11:11:10 +0900
Subject: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree
In-Reply-To: <566AB2A5.4090105@cogentembedded.com>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
 <566AB2A5.4090105@cogentembedded.com>
Message-ID: <20151214021110.GD13945@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Dec 11, 2015 at 02:25:25PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/11/2015 5:52 AM, Simon Horman wrote:
> 
> >Activate i2c2 bus in r8a7793/gose device tree.
> >
> >Based on similar work for the r8a7791/koelsch by Wolfram Sang.
> >
> >Cc: Wolfram Sang <wsa@sang-engineering.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/boot/dts/r8a7793-gose.dts | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> >index 3e3122490650..9a71ff6d4474 100644
> >--- a/arch/arm/boot/dts/r8a7793-gose.dts
> >+++ b/arch/arm/boot/dts/r8a7793-gose.dts
> [...]
> >@@ -135,3 +140,17 @@
> >  		};
> >  	};
> >  };
> >+
> >+&i2c2 {
> >+	pinctrl-0 = <&i2c2_pins>;
> >+	pinctrl-names = "default";
> >+
> >+	status = "okay";
> >+	clock-frequency = <100000>;
> >+
> >+	eeprom at 50 {
> >+		compatible = "renesas,24c02";
> 
>    This is not a valid value -- the Renesas chip model is different from 24c02.

I copied this value from r8a7791.dtsi.

Looking at the schematic for gose (v100), koelsch (rev024) and porter (v300)
I see the following "R1EX24002ATAS0G#U0". Shall we update r8a7791 and
this patch to "renesas,24002" or leave things as is?
