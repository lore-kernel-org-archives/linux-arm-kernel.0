From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 12 Jan 2017 03:55:33 +0800
Subject: [PATCH 4/4] ARM: dts: sun8i: add OTG function to Lichee Pi Zero
In-Reply-To: <20170110202443.GC2479@uda0271908>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
 <20170103152534.20118-5-icenowy@aosc.xyz> <20170110202443.GC2479@uda0271908>
Message-ID: <2733831484164533@web1g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



11.01.2017, 04:24, "Bin Liu" <b-liu@ti.com>:
> On Tue, Jan 03, 2017 at 11:25:34PM +0800, Icenowy Zheng wrote:
>> ?Lichee Pi Zero features a USB OTG port.
>>
>> ?Add support for it.
>>
>> ?Note: in order to use the Host mode, the board must be powered via the
>> ?+5V and GND pins.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ??arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 10 ++++++++++
>> ??1 file changed, 10 insertions(+)
>>
>> ?diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
>> ?index 0099affc6ce3..3d9168cbaeca 100644
>> ?--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
>> ?+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
>> ?@@ -71,3 +71,13 @@
>> ??????????pinctrl-names = "default";
>> ??????????status = "okay";
>> ??};
>> ?+
>> ?+&usb_otg {
>> ?+ dr_mode = "otg";
>
> Why not set this default mode in dtsi instead?
>
> Regards,
> -Bin.

There's possibly boards which do not have OTG functions.

Even the official CDR design of V3s uses the USB controller to
connect a UVC webcam to make the design a dual-cam design
(V3s itself has a CSI).

>
>> ?+ status = "okay";
>> ?+};
>> ?+
>> ?+&usbphy {
>> ?+ usb0_id_det-gpio = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>> ?+ status = "okay";
>> ?+};
>> ?--
>> ?2.11.0
