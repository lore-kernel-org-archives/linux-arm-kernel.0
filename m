From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 18:39:21 +0100
Subject: [PATCH 1/8] dt-bindings: pmic: Document Hi655x pmic driver
In-Reply-To: <1443611111-3196-2-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
 <1443611111-3196-2-git-send-email-w.f@huawei.com>
Message-ID: <20150930173921.GJ15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 07:05:04PM +0800, Fei Wang wrote:

> +Hisilicon hi655x Power Management Integrated Circuit (PMIC)
> +
> +hi655x consists of a large and varied group of sub-devices:
> +
> +Device			 Supply Names	 Description
> +------			 ------------	 -----------
> +hi655x-powerkey		:		: Powerkey
> +hi655x-regulator-pmic	:		: Regulators
> +hi655x-usbvbus		:		: USB plug detection
> +hi655x-pmu-rtc		:		: RTC
> +hi655x-coul		:		: Coulomb

...counter?

There's no documentation of the bindings for any of the above devices or
how things are structured, you need to provide binding documentation
which is understandable standalone.  None of the properties are
documented, nor is the set of regulators supported or how this is
structured.

> +                coul: coul at 1 {
> +                        compatible = "hisilicon,hi655x-coul";
> +                        interrupt-parent = <&pmic>;
> +                        interrupts = <24 0>, <25 0>, <26 0>, <27 0>;
> +                        interrupt-names = "cl_int_i", "cl_out_i", "cl_in_i", "vbat_int_i";
> +                        battery_product_index = <0>;

For example, the "battery_product_index" property here is undocumented.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/57546c23/attachment.sig>
