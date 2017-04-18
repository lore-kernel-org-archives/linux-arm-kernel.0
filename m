From: w.egorov@phytec.de (Wadim Egorov)
Date: Tue, 18 Apr 2017 17:01:41 +0200
Subject: [PATCH v2 1/3] ARM: dts: rockchip: Add support for phyCORE-RK3288
 SoM
In-Reply-To: <CAFLEztSQ1-WU7KAXzuB66htXiaQN4wd=XmM5XtjZcoONt77XmQ@mail.gmail.com>
References: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
 <CAFLEztSQ1-WU7KAXzuB66htXiaQN4wd=XmM5XtjZcoONt77XmQ@mail.gmail.com>
Message-ID: <381e11bc-649d-ddf2-4a28-f72a264204c3@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +&i2c0 {
>> +       status = "okay";
>> +       clock-frequency = <400000>;
>> +
>> +       rk818: pmic at 1c {
>> +               compatible = "rockchip,rk818";
>> +               reg = <0x1c>;
>> +               interrupt-parent = <&gpio0>;
>> +               interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pmic_int>;
>> +               rockchip,system-power-controller;
>> +               wakeup-source;
>> +               #clock-cells = <1>;
>> +
> I think you miss  "clock-output-names = "xin32k" here.
Yes, thanks for catching that. I will fix this later.
