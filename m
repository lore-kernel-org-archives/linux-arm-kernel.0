From: tcmichals@gmail.com (Tim Michals)
Date: Fri, 2 Nov 2012 22:50:13 -0500
Subject: i2c support for imx23 linux-3.7-rc3 imx23-olinuxino
Message-ID: <CANqk_c9HtgV1BnTAaK+M=NXwvsY91yqmOQNMwJwT_X65_rMhqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After updating device tree files in  linux-3.7-rc3
 imx23.dts:
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
i2c0: i2c at 80058000 {
#address-cells = <1>;
#size-cells = <0>;
compatible = "fsl,imx28-i2c";
reg = <0x80058000 0x2000>;
interrupts = <27 26>;
clock-frequency = <100000>;
fsl,i2c-dma-channel = <3>;
status = "disabled";
};
imx23-olinuxino.dts
i2c0: i2c at 80058000 {
pinctrl-names = "default";
pinctrl-0 = <&i2c0_pins_a>;
status = "okay";
 };
using i2cdetect -r 0 to scan for devices the following message repeats:
 [  647.380000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
descriptor..

# i2cdetect -l

i2c-0   i2c             MXS I2C adapter                         I2C adapter
If I load fsl kernel 2.6.35 it works fine.. Is it my dts files? Or
interrupt processing issues?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/66748c06/attachment-0001.html>
