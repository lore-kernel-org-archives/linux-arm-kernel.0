From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Nov 2017 14:54:37 -0200
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <20171113161522.2kq7un7gl5vg4qlq@piout.net>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
Message-ID: <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Mon, Nov 13, 2017 at 2:15 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Fabio, is there any recent change in the platform code that would make
> reading/writing the rtc register fail?

I don't recall of any recent change in this area.

Patrick/Noel,

Does the change below help?

--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -436,8 +436,7 @@
                        srtc: srtc at 53fa4000 {
                                compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
                                reg = <0x53fa4000 0x4000>;
-                               interrupts = <24>;
-                               interrupt-parent = <&tzic>;
+                               interrupts = <24 25>;
                                clocks = <&clks IMX5_CLK_SRTC_GATE>;
                                clock-names = "ipg";
                        };
