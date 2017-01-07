From: andi@etezian.org (Andi Shyti)
Date: Sat, 7 Jan 2017 21:40:26 +0900
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
 <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
 <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
 <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
Message-ID: <20170107124026.gl447hl5bucdflyk@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

> >>> +       touchkey at 20 {
> >>> +               compatible = "samsung,tm2-touchkey";
> >>> +               reg = <0x20>;
> >>> +               interrupt-parent = <&gpa3>;
> >>> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> >>> +               vcc-supply = <&ldo32_reg>;
> >>> +               vdd-supply = <&ldo33_reg>;
> >>> +       };
> >>> +};
> >>> +
> >>>  &ldo31_reg {
> >>>         regulator-name = "TSP_VDD_1.85V_AP";
> >>>         regulator-min-microvolt = <1850000>;
> 
> I repiled the touchkey driver against compatible name.
> Usually, when developing the device driver, we use the specific h/w name
> but in this patch, the touckey dt node uses the h/w board name instead of
> original touckhey name.

this should be a device specifically done for the tm2 and we are
not sure who is the manufacturer of the device. In order to not
assign the device to the wrong manufacturer, we preferred calling
it Samsung as it is in a Samsung device.

Andi
