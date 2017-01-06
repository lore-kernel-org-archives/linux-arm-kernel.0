From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 7 Jan 2017 07:15:32 +0900
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
 <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
 <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
Message-ID: <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2017-01-07 7:09 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
> Hi,
>
> 2017-01-07 6:31 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
>> Hi,
>>
>> 2017-01-06 22:43 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
>>> From: Jaechul Lee <jcsing.lee@samsung.com>
>>>
>>> Add DT node support for TM2 touchkey device.
>>>
>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
>>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
>>> index 2449266b268f..92fcc4ec8319 100644
>>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
>>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
>>> @@ -18,6 +18,19 @@
>>>         compatible = "samsung,tm2", "samsung,exynos5433";
>>>  };
>>>
>>> +&hsi2c_9 {
>>> +       status = "okay";
>>> +
>>> +       touchkey at 20 {
>>> +               compatible = "samsung,tm2-touchkey";
>>> +               reg = <0x20>;
>>> +               interrupt-parent = <&gpa3>;
>>> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>>> +               vcc-supply = <&ldo32_reg>;
>>> +               vdd-supply = <&ldo33_reg>;
>>> +       };
>>> +};
>>> +
>>>  &ldo31_reg {
>>>         regulator-name = "TSP_VDD_1.85V_AP";
>>>         regulator-min-microvolt = <1850000>;
>>
>> Looks good to me.
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

I'm sorry to send the empty mail without any content.

I repiled the touchkey driver against compatible name.
Usually, when developing the device driver, we use the specific h/w name
but in this patch, the touckey dt node uses the h/w board name instead of
original touckhey name.

If this touckey device is used on other h/w board, I think the current
compatible name
is not proper.

So. please drop the my reviewed-by tag until completing the discussion.
I'm sorry to make the confusion.

-- 
Best Regards,
Chanwoo Choi
