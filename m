From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 8 Jan 2017 14:14:20 +0900
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <20170107124026.gl447hl5bucdflyk@jack.zhora.eu>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
 <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
 <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
 <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
 <20170107124026.gl447hl5bucdflyk@jack.zhora.eu>
Message-ID: <CAGTfZH35sx5v-XcxkDG7TVRmW8cLirAXRxA=kGZQDBnpw3vYhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

2017-01-07 21:40 GMT+09:00 Andi Shyti <andi@etezian.org>:
> Hi Chanwoo,
>
>> >>> +       touchkey at 20 {
>> >>> +               compatible = "samsung,tm2-touchkey";
>> >>> +               reg = <0x20>;
>> >>> +               interrupt-parent = <&gpa3>;
>> >>> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>> >>> +               vcc-supply = <&ldo32_reg>;
>> >>> +               vdd-supply = <&ldo33_reg>;
>> >>> +       };
>> >>> +};
>> >>> +
>> >>>  &ldo31_reg {
>> >>>         regulator-name = "TSP_VDD_1.85V_AP";
>> >>>         regulator-min-microvolt = <1850000>;
>>
>> I repiled the touchkey driver against compatible name.
>> Usually, when developing the device driver, we use the specific h/w name
>> but in this patch, the touckey dt node uses the h/w board name instead of
>> original touckhey name.
>
> this should be a device specifically done for the tm2 and we are
> not sure who is the manufacturer of the device. In order to not

As I knew, this touchkey was made by Cypress semiconductor.
But, for more correct information, you may try to find it.

> assign the device to the wrong manufacturer, we preferred calling
> it Samsung as it is in a Samsung device.

As you mentioned, Samsung made not this touchkey device. It is
certainly wrong manufacturer. I have not seen to use the h/w board
name as the peripheral device name.

I don't prefer to use the inaccurate manufacturer and device name.

-- 
Best Regards,
Chanwoo Choi
