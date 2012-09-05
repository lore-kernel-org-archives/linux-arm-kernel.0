From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 05 Sep 2012 15:50:40 +0200
Subject: [PATCH v3 1/4] pinctrl: add samsung pinctrl and gpiolib driver
References: <1345720529-32315-1-git-send-email-thomas.abraham@linaro.org>
 <1345720529-32315-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <k27lbg$hrj$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Abraham wrote:
> Add a new device tree enabled pinctrl and gpiolib driver for Samsung
> SoC's. This driver provides a common and extensible framework for all
> Samsung SoC's to interface with the pinctrl and gpiolib subsystems. This
> driver supports only device tree based instantiation and hence can be
> used only on those Samsung platforms that have device tree enabled.
> 
> This driver is split into two parts: the pinctrl interface and the gpiolib
> interface. The pinctrl interface registers pinctrl devices with the
> pinctrl subsystem and gpiolib interface registers gpio chips with the
> gpiolib subsystem. The information about the pins, pin groups, pin
> functions and gpio chips, which are SoC specific, are parsed from device
> tree node.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Does the driver provide any kind of compatibility with current gpiolib 
users?

Let me show an example of what I mean. We have a fixed voltage regulator 
defined in device tree of an imaginary board

	vemmc_reg: voltage-regulator at 0 {
	        compatible = "regulator-fixed";
		regulator-name = "VMEM_VDD_2.8V";
		regulator-min-microvolt = <2800000>;
		regulator-max-microvolt = <2800000>;
		gpio = <&gpk0 2 1 0 0>;
		enable-active-high;
	};

The gpio pin used to control status of the regulator is defined using the 
gpio property and regulator-fixed driver uses of_get_named_gpio to get the 
pin number from device tree.

Is this kind of setup also valid when using your pinctrl driver?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
