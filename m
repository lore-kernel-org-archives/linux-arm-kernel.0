From: paulliu@debian.org (Ying-Chun Liu (PaulLiu))
Date: Thu, 05 Jul 2012 14:46:24 +0800
Subject: [PATCH 1/2] mfd: Add Freescale's PMIC MC34708 support
In-Reply-To: <CAAQ0ZWST5DgS+2Er5EsNscxXtThO7H9-HAO=TtM6Me7EHygK7w@mail.gmail.com>
References: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
 <20120704073749.GD5398@pengutronix.de>
 <CAAQ0ZWST5DgS+2Er5EsNscxXtThO7H9-HAO=TtM6Me7EHygK7w@mail.gmail.com>
Message-ID: <4FF53840.3070802@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?07?04? 21:44), Shawn Guo wrote:
> On 4 July 2012 15:37, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>> I want to push that forward. What is the state of these patches on your
>> end? Did you start to address the comments? Are there more recent
>> patches than the ones in this thread?
>>
>> Whatever you might have it would be great if you could share it to help
>> preventing duplicate efforts.
>>
> As far as I know, Paul hasn't been on that effort any more.
> 
> Copied his another email address.
> 
> Regards,
> Shawn

Hi,

Sorry, forget to mention about this.
We have a patch for the DTS corresponding to this patch.

>From f3d28445de908bf2a848f6e8104b5c7f347ecd64 Mon Sep 17 00:00:00 2001
From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Date: Thu, 19 Apr 2012 15:24:10 +0800
Subject: [PATCH] arm: imx53-qsb: Add Ripley driver DT nodes

This patch adds the ripley driver and regulators.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 arch/arm/boot/dts/imx53-qsb.dts |  104
+++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts
b/arch/arm/boot/dts/imx53-qsb.dts
index 5c57c86..c95bad7 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -80,6 +80,110 @@
 					compatible = "dialog,da9053", "dialog,da9052";
 					reg = <0x48>;
 				};
+
+				ripley at 8 {
+					compatible = "fsl,mc34708";
+					reg = <0x08>;
+					regulators {
+						mc34708__sw1a {
+							regulator-name = "SW1";
+							regulator-min-microvolt = <650000>;
+							regulator-max-microvolt = <1437500>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__sw1b {
+							regulator-name = "SW1B";
+							regulator-min-microvolt = <650000>;
+							regulator-max-microvolt = <1437500>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__sw2 {
+							regulator-name = "SW2";
+							regulator-min-microvolt = <650000>;
+							regulator-max-microvolt = <1437500>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__sw3 {
+							regulator-name = "SW3";
+							regulator-min-microvolt = <650000>;
+							regulator-max-microvolt = <1425000>;
+							regulator-boot-on;
+						};
+						mc34708__sw4a {
+							regulator-name = "SW4A";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__sw4b {
+							regulator-name = "SW4B";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__sw5 {
+							regulator-name = "SW5";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <1975000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__swbst {
+							regulator-name = "SWBST";
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vpll {
+							regulator-name = "VPLL";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <1800000>;
+							regulator-boot-on;
+						};
+						mc34708__vrefddr {
+							regulator-name = "VREFDDR";
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vusb {
+							regulator-name = "VUSB";
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vusb2 {
+							regulator-name = "VUSB2";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <3000000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vdac {
+							regulator-name = "VDAC";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <2775000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vgen1 {
+							regulator-name = "VGEN1";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <1550000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+						mc34708__vgen2 {
+							regulator-name = "VGEN2";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-boot-on;
+							regulator-always-on;
+						};
+					};
+				};
 			};

 			fec at 63fec000 {
-- 
1.7.10


Thanks,
Paul

-- 
                                PaulLiu (???)
E-mail: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 900 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/0a495513/attachment.sig>
