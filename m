From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 21 Aug 2016 16:46:42 +0900
Subject: [PATCH 6/7] arm64: dts: exynos: Add dts file for Exynos5433-based
 TM2 board
In-Reply-To: <0aba7694-e5fc-47be-dce6-06f64fb3759d@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-2-git-send-email-cw00.choi@samsung.com>
 <0aba7694-e5fc-47be-dce6-06f64fb3759d@samsung.com>
Message-ID: <CAGTfZH0kqwJhZBh_trnK4JstpkVdyHSr6frvdVq4Z=Pxzzp0Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-20 2:05 GMT+09:00 Sylwester Nawrocki <s.nawrocki@samsung.com>:
> On 08/16/2016 08:35 AM, Chanwoo Choi wrote:
>> &spi_1 {
>> +     cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
>> +     status = "okay";
>> +
>> +     wm5110: wm5110-codec at 0 {
>> +             compatible = "wlf,wm5110";
>> +             reg = <0x0>;
>> +             spi-max-frequency = <20000000>;
>> +             interrupt-parent = <&gpa0>;
>> +             interrupts = <4 0 0>;
>> +             clocks = <&xxti>, <&s2mps13_osc 2>;
>
> The first clock needs to be CLKOUT, i.e.
>
>         clocks = <&pmu_system_controller 0>, <&s2mps13_osc 2>;
>

OK.

-- 
Best Regards,
Chanwoo Choi
