From: tcmichals@yahoo.com (Tim michals)
Date: Sat, 13 Oct 2012 02:48:13 -0000
Subject: Testing i2c in 3.6.0-next-20121012 for i.mx233
Message-ID: <1350096488.12723.YahooMailNeo@web162606.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the?3.6.0-next-20121012 ?to test i2c DMA support on a imx233-Olinuxino-micro?board. ?When using the i2cdetect -r 0 to scan a devices on the i2c bus, ?the following message is displayed on the console:

-- [ ?129.130000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write descriptor.

imx23.dtsi support for i2c:
i2c0_pins_a: i2c0 at 0 {
reg = <0>;
fsl,pinmux-ids = <
0x1171 /* MX23_PAD_LCD_ENABLE__LCD_ENABLE */
0x1181 /* MX23_PAD_LCD_HSYNC__LCD_HSYNC */
>;
fsl,drive-strength = <1>;
fsl,voltage = <1>;
fsl,pull-up = <1>;
};
...
i2c at 80058000 {
#address-cells = <1>;
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?#size-cells = <0>;
compatible = "fsl,imx28-i2c";
reg = <0x80058000 0x2000>;
interrupts = <27 26>;
clock-frequency = <400000>;
fsl,i2c-dma-channel = <3>;
status = "disabled";
};
imx23-olinuxino.dts
i2c0: i2c at 80058000 {
 ? ? ?pinctrl-names = "default";
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pinctrl-0 = <&i2c0_pins_a>;
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?status = "okay";
? ? ? ? ? ? ? ? ? ? ? ?};
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121013/8dc310ec/attachment.html>
