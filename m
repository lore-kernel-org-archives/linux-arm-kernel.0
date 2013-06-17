From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 17 Jun 2013 09:21:43 +0800
Subject: [PATCH v4 7/7] ARM: hi3xxx: enable hi4511 with device tree
In-Reply-To: <20130612200042.GC5162@quad.lixom.net>
References: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
 <1370702843-27172-8-git-send-email-haojian.zhuang@linaro.org>
 <20130612200042.GC5162@quad.lixom.net>
Message-ID: <CAD6h2NQ7ZQQnZcqbM9DkiHJ01jU-ALtrOU9-StND2Ss10c9-iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 June 2013 04:00, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Sat, Jun 08, 2013 at 10:47:23PM +0800, Haojian Zhuang wrote:
>> Enable Hisilicon Hi4511 development platform with device tree support.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>> + * publishhed by the Free Software Foundation.
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +             serial1 = &uart1;
>> +             serial2 = &uart2;
>> +             serial3 = &uart3;
>> +             serial4 = &uart4;
>> +     };
>> +
>> +     osc32k: osc at 0 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32768>;
>> +             clock-output-names = "osc32khz";
>> +     };
>> +     osc26m: osc at 1 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <26000000>;
>> +             clock-output-names = "osc26mhz";
>> +     };
>> +     pclk: clk at 0 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <26000000>;
>> +             clock-output-names = "apb_pclk";
>> +     };
>> +     pll_arm0: clk at 1 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1600000000>;
>> +             clock-output-names = "armpll0";
>> +     };
>> +     pll_arm1: clk at 2 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1600000000>;
>> +             clock-output-names = "armpll1";
>> +     };
>> +     pll_peri: clk at 3 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1440000000>;
>> +             clock-output-names = "armpll2";
>> +     };
>> +     pll_usb: clk at 4 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1440000000>;
>> +             clock-output-names = "armpll3";
>> +     };
>> +     pll_hdmi: clk at 5 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1188000000>;
>> +             clock-output-names = "armpll4";
>> +     };
>> +     pll_gpu: clk at 6 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1300000000>;
>> +             clock-output-names = "armpll5";
>> +     };
>> +
>> +     amba {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             compatible = "arm,amba-bus";
>> +             interrupt-parent = <&intc>;
>> +             ranges;
>> +
>> +             pmctrl: pmctrl at fca08000 {
>> +                     compatible = "hisilicon,pmctrl";
>> +                     reg = <0xfca08000 0x1000>;
>> +             };
>> +
>> +             sctrl: sctrl at fc802000 {
>> +                     compatible = "hisilicon,sctrl";
>> +                     reg = <0xfc802000 0x1000>;
>> +
>> +                     uart0_mux: uart0_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &pclk>;
>> +                             clock-output-names = "uart0_mux";
>> +                             /* reg_offset, mask bits */
>> +                             hisilicon,clkmux-reg = <0x100 0x80>;
>> +                             /* each item value */
>> +                             hisilicon,clkmux-table = <0 0x80>;
>> +                     };
>> +                     uart1_mux: uart1_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &pclk>;
>> +                             clock-output-names = "uart1_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x100>;
>> +                             hisilicon,clkmux-table = <0x0 0x100>;
>> +                     };
>> +                     uart2_mux: uart2_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &pclk>;
>> +                             clock-output-names = "uart2_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x200>;
>> +                             hisilicon,clkmux-table = <0 0x200>;
>> +                     };
>> +                     uart3_mux: uart3_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &pclk>;
>> +                             clock-output-names = "uart3_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x400>;
>> +                             hisilicon,clkmux-table = <0 0x400>;
>> +                     };
>> +                     uart4_mux: uart4_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &pclk>;
>> +                             clock-output-names = "uart4_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x800>;
>> +                             hisilicon,clkmux-table = <0 0x800>;
>> +                     };
>> +                     rclk_cfgaxi: rclk_cfgaxi {
>> +                             compatible = "fixed-factor-clock";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pll_peri>;
>> +                             clock-output-names = "rclk_cfgaxi";
>> +                             clock-mult = <1>;
>> +                             clock-div = <30>;
>> +                     };
>> +                     spi0_mux: spi0_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &rclk_cfgaxi>;
>> +                             clock-output-names = "spi0_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x1000>;
>> +                             hisilicon,clkmux-table = <0 0x1000>;
>> +                     };
>> +                     spi1_mux: spi1_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &rclk_cfgaxi>;
>> +                             clock-output-names = "spi1_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x2000>;
>> +                             hisilicon,clkmux-table = <0 0x2000>;
>> +                     };
>> +                     spi2_mux: spi2_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m &rclk_cfgaxi>;
>> +                             clock-output-names = "spi2_mux";
>> +                             hisilicon,clkmux-reg = <0x100 0x4000>;
>> +                             hisilicon,clkmux-table = <0 0x4000>;
>> +                     };
>> +                     pwm0_mux: pwm0_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &osc26m>;
>> +                             clock-output-names = "pwm0_mux";
>> +                             hisilicon,clkmux-reg = <0x104 0x400>;
>> +                             hisilicon,clkmux-table = <0 0x400>;
>> +                     };
>> +                     pwm1_mux: pwm1_mux {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &osc26m>;
>> +                             clock-output-names = "pwm1_mux";
>> +                             hisilicon,clkmux-reg = <0x104 0x800>;
>> +                             hisilicon,clkmux-table = <0 0x800>;
>> +                     };
>> +                     timer0_mux: timer0_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk01>;
>> +                             clock-output-names = "timer0_mux";
>> +                             hisilicon,clkmux-reg = <0 0x8000>;
>> +                             hisilicon,clkmux-table = <0 0x8000>;
>> +                     };
>> +                     timer1_mux: timer1_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk01>;
>> +                             clock-output-names = "timer1_mux";
>> +                             hisilicon,clkmux-reg = <0 0x20000>;
>> +                             hisilicon,clkmux-table = <0 0x20000>;
>> +                     };
>> +                     timer2_mux: timer2_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk23>;
>> +                             clock-output-names = "timer2_mux";
>> +                             hisilicon,clkmux-reg = <0 0x80000>;
>> +                             hisilicon,clkmux-table = <0 0x80000>;
>> +                     };
>> +                     timer3_mux: timer3_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk23>;
>> +                             clock-output-names = "timer3_mux";
>> +                             hisilicon,clkmux-reg = <0 0x200000>;
>> +                             hisilicon,clkmux-table = <0 0x200000>;
>> +                     };
>> +                     timer4_mux: timer4_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk45>;
>> +                             clock-output-names = "timer4_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x1>;
>> +                             hisilicon,clkmux-table = <0 0x1>;
>> +                     };
>> +                     timer5_mux: timer5_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk45>;
>> +                             clock-output-names = "timer5_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x4>;
>> +                             hisilicon,clkmux-table = <0 0x4>;
>> +                     };
>> +                     timer6_mux: timer6_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk67>;
>> +                             clock-output-names = "timer6_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x10>;
>> +                             hisilicon,clkmux-table = <0 0x10>;
>> +                     };
>> +                     timer7_mux: timer7_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk67>;
>> +                             clock-output-names = "timer7_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x40>;
>> +                             hisilicon,clkmux-table = <0 0x40>;
>> +                     };
>> +                     timer8_mux: timer8_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk89>;
>> +                             clock-output-names = "timer8_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x100>;
>> +                             hisilicon,clkmux-table = <0 0x100>;
>> +                     };
>> +                     timer9_mux: timer9_mux {
>> +                             compatible = "hisilicon,clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k &timerclk89>;
>> +                             clock-output-names = "timer9_mux";
>> +                             hisilicon,clkmux-reg = <0x18 0x400>;
>> +                             hisilicon,clkmux-table = <0 0x400>;
>> +                     };
>> +                     rclk_shareAXI: rclk_shareAXI {
>> +                             compatible = "hisilicon,hi3620-clk-mux";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pll_usb &pll_peri>;
>> +                             clock-output-names = "rclk_shareAXI";
>> +                             hisilicon,clkmux-reg = <0x100 0x8000>;
>> +                             hisilicon,clkmux-table = <0 0x8000>;
>> +                     };
>> +                     uartclk0: uartclk0 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&uart0_mux>;
>> +                             clock-output-names = "uartclk0";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x10000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x10000>;
>> +                     };
>> +                     uartclk1: uartclk1 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&uart1_mux>;
>> +                             clock-output-names = "uartclk1";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x20000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x20000>;
>> +                     };
>> +                     uartclk2: uartclk2 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&uart2_mux>;
>> +                             clock-output-names = "uartclk2";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x40000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x40000>;
>> +                     };
>> +                     uartclk3: uartclk3 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&uart3_mux>;
>> +                             clock-output-names = "uartclk3";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x80000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x80000>;
>> +                     };
>> +                     uartclk4: uartclk4 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&uart4_mux>;
>> +                             clock-output-names = "uartclk4";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x100000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x100000>;
>> +                     };
>> +                     gpioclk0: gpioclk0 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk0";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x100>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x100>;
>> +                     };
>> +                     gpioclk1: gpioclk1 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk1";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x200>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x200>;
>> +                     };
>> +                     gpioclk2: gpioclk2 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk2";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x400>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x400>;
>> +                     };
>> +                     gpioclk3: gpioclk3 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk3";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x800>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x800>;
>> +                     };
>> +                     gpioclk4: gpioclk4 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk4";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x1000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x1000>;
>> +                     };
>> +                     gpioclk5: gpioclk5 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk5";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x2000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x2000>;
>> +                     };
>> +                     gpioclk6: gpioclk6 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk6";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x4000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x4000>;
>> +                     };
>> +                     gpioclk7: gpioclk7 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk7";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x8000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x8000>;
>> +                     };
>> +                     gpioclk8: gpioclk8 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk8";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x10000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x10000>;
>> +                     };
>> +                     gpioclk9: gpioclk9 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk9";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x20000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x20000>;
>> +                     };
>> +                     gpioclk10: gpioclk10 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk10";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x40000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x40000>;
>> +                     };
>> +                     gpioclk11: gpioclk11 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk11";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x80000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x80000>;
>> +                     };
>> +                     gpioclk12: gpioclk12 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk12";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x100000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x100000>;
>> +                     };
>> +                     gpioclk13: gpioclk13 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk13";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x200000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x200000>;
>> +                     };
>> +                     gpioclk14: gpioclk14 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk14";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x400000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x400000>;
>> +                     };
>> +                     gpioclk15: gpioclk15 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk15";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x800000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x800000>;
>> +                     };
>> +                     gpioclk16: gpioclk16 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk16";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x1000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x1000000>;
>> +                     };
>> +                     gpioclk17: gpioclk17 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk17";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x2000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x2000000>;
>> +                     };
>> +                     gpioclk18: gpioclk18 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk18";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x4000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x4000000>;
>> +                     };
>> +                     gpioclk19: gpioclk19 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk19";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x8000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x8000000>;
>> +                     };
>> +                     gpioclk20: gpioclk20 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk20";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x10000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x10000000>;
>> +                     };
>> +                     gpioclk21: gpioclk21 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pclk>;
>> +                             clock-output-names = "gpioclk21";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x20000000>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x20000000>;
>> +                     };
>> +                     spiclk0: spiclk0 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&spi0_mux>;
>> +                             clock-output-names = "spiclk0";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x200000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x200000>;
>> +                     };
>> +                     spiclk1: spiclk1 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&spi1_mux>;
>> +                             clock-output-names = "spiclk1";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x400000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x400000>;
>> +                     };
>> +                     spiclk2: spiclk2 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&spi2_mux>;
>> +                             clock-output-names = "spiclk2";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x800000>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x800000>;
>> +                     };
>> +                     pwmclk0: pwmclk0 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pwm0_mux>;
>> +                             clock-output-names = "pwmclk0";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x80>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x80>;
>> +                     };
>> +                     pwmclk1: pwmclk1 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&pwm1_mux>;
>> +                             clock-output-names = "pwmclk1";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x100>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x100>;
>> +                     };
>> +                     timerclk01: timerclk01 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m>;
>> +                             clock-output-names = "timerclk01";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x1>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0x3>;
>> +                     };
>> +                     timerclk23: timerclk23 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m>;
>> +                             clock-output-names = "timerclk23";
>> +                             hisilicon,hi3620-clkreset = <0x80 0x2>;
>> +                             hisilicon,hi3620-clkgate = <0x20 0xc>;
>> +                     };
>> +                     timerclk45: timerclk45 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m>;
>> +                             clock-output-names = "timerclk45";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x8>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x8>;
>> +                     };
>> +                     timerclk67: timerclk67 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m>;
>> +                             clock-output-names = "timerclk67";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x10>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x10>;
>> +                     };
>> +                     timerclk89: timerclk89 {
>> +                             compatible = "hisilicon,hi3620-clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc26m>;
>> +                             clock-output-names = "timerclk89";
>> +                             hisilicon,hi3620-clkreset = <0x98 0x20>;
>> +                             hisilicon,hi3620-clkgate = <0x40 0x20>;
>> +                     };
>> +                     timclk0: timclk0 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer0_mux>;
>> +                             clock-output-names = "timclk0";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0 16>;
>> +                     };
>> +                     timclk1: timclk1 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer1_mux>;
>> +                             clock-output-names = "timclk1";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0 18>;
>> +                     };
>> +                     timclk2: timclk2 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer2_mux>;
>> +                             clock-output-names = "timclk2";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0 20>;
>> +                     };
>> +                     timclk3: timclk3 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer3_mux>;
>> +                             clock-output-names = "timclk3";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0 22>;
>> +                     };
>> +                     timclk4: timclk4 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer4_mux>;
>> +                             clock-output-names = "timclk4";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 0>;
>> +                     };
>> +                     timclk5: timclk5 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer5_mux>;
>> +                             clock-output-names = "timclk5";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 2>;
>> +                     };
>> +                     timclk6: timclk6 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer6_mux>;
>> +                             clock-output-names = "timclk6";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 4>;
>> +                     };
>> +                     timclk7: timclk7 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer7_mux>;
>> +                             clock-output-names = "timclk7";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 6>;
>> +                     };
>> +                     timclk8: timclk8 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer8_mux>;
>> +                             clock-output-names = "timclk8";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 8>;
>> +                     };
>> +                     timclk9: timclk9 {
>> +                             compatible = "hisilicon,clk-gate";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&timer9_mux>;
>> +                             clock-output-names = "timclk9";
>> +                             hisilicon,clkgate-inverted;
>> +                             hisilicon,clkgate = <0x18 10>;
>> +                     };
>> +                     dtable: dtable {
>> +                             #hisilicon,clkdiv-table-cells = <2>;
>> +                     };
>> +                     div_shareaxi: div_shareaxi {
>> +                             compatible = "hisilicon,hi3620-clk-div";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&rclk_shareAXI>;
>> +                             clock-output-names = "shareAXI_div";
>> +                             hisilicon,clkdiv-table = <
>> +                                     &dtable 0 1 &dtable 1 2 &dtable 2 3 &dtable 3 4
>> +                                     &dtable 4 5 &dtable 5 6 &dtable 6 7 &dtable 7 8
>> +                                     &dtable 8 9 &dtable 9 10 &dtable 10 11 &dtable 11 12
>> +                                     &dtable 12 13 &dtable 13 14 &dtable 14 15 &dtable 15 16
>> +                                     &dtable 16 17 &dtable 17 18 &dtable 18 19 &dtable 19 20
>> +                                     &dtable 20 21 &dtable 21 22 &dtable 22 23 &dtable 23 24
>> +                                     &dtable 24 25 &dtable 25 26 &dtable 26 27 &dtable 27 28
>> +                                     &dtable 28 29 &dtable 29 30 &dtable 30 31 &dtable 31 32>;
>> +                             /* divider register offset, mask */
>> +                             hisilicon,clkdiv = <0x100 0x1f>;
>> +                     };
>> +                     div_cfgaxi: div_cfgaxi {
>> +                             compatible = "hisilicon,hi3620-clk-div";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&div_shareaxi>;
>> +                             clock-output-names = "cfgAXI_div";
>> +                             hisilicon,clkdiv-table = <&dtable 0x01 2>;
>> +                             hisilicon,clkdiv = <0x100 0x60>;
>> +                     };
>> +             };
>> +
>> +             l2: l2-cache {
>> +                     compatible = "arm,pl310-cache";
>> +                     reg = <0xfc10000 0x100000>;
>> +                     interrupts = <0 15 4>;
>> +                     cache-unified;
>> +                     cache-level = <2>;
>> +             };
>> +
>> +             intc: interrupt-controller at fc001000 {
>> +                     compatible = "arm,cortex-a9-gic";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
>> +                     interrupt-controller;
>> +                     /* gic dist base, gic cpu base */
>> +                     reg = <0xfc001000 0x1000>, <0xfc000100 0x100>;
>> +             };
>> +
>> +             timer0: timer at fc800000 {
>> +                     compatible = "arm,sp804", "arm,primecell";
>> +                     reg = <0xfc800000 0x1000>;
>> +                     /* timer00 & timer01 */
>> +                     interrupts = <0 0 4>, <0 1 4>;
>> +                     clocks = <&timclk0 &timclk1>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer1: timer at fc801000 {
>> +                     compatible = "arm,sp804", "arm,primecell";
>> +                     reg = <0xfc801000 0x1000>;
>> +                     /* timer10 & timer11 */
>> +                     interrupts = <0 2 4>, <0 3 4>;
>> +                     clocks = <&timclk2 &timclk3>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer2: timer at fca01000 {
>> +                     compatible = "arm,sp804", "arm,primecell";
>> +                     reg = <0xfca01000 0x1000>;
>> +                     /* timer20 & timer21 */
>> +                     interrupts = <0 4 4>, <0 5 4>;
>> +                     clocks = <&timclk4 &timclk5>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer3: timer at fca02000 {
>> +                     compatible = "arm,sp804", "arm,primecell";
>> +                     reg = <0xfca02000 0x1000>;
>> +                     /* timer30 & timer31 */
>> +                     interrupts = <0 6 4>, <0 7 4>;
>> +                     clocks = <&timclk6 &timclk7>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer4: timer at fca03000 {
>> +                     compatible = "arm,sp804", "arm,primecell";
>> +                     reg = <0xfca03000 0x1000>;
>> +                     /* timer40 & timer41 */
>> +                     interrupts = <0 96 4>, <0 97 4>;
>> +                     clocks = <&timclk8 &timclk9>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             uart0: uart at fcb00000 {
>> +                     compatible = "arm,pl011", "arm,primecell";
>> +                     reg = <0xfcb00000 0x1000>;
>> +                     interrupts = <0 20 4>;
>> +                     clocks = <&uartclk0>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             uart1: uart at fcb01000 {
>> +                     compatible = "arm,pl011", "arm,primecell";
>> +                     reg = <0xfcb01000 0x1000>;
>> +                     interrupts = <0 21 4>;
>> +                     clocks = <&uartclk1>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             uart2: uart at fcb02000 {
>> +                     compatible = "arm,pl011", "arm,primecell";
>> +                     reg = <0xfcb02000 0x1000>;
>> +                     interrupts = <0 22 4>;
>> +                     clocks = <&uartclk2>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             uart3: uart at fcb03000 {
>> +                     compatible = "arm,pl011", "arm,primecell";
>> +                     reg = <0xfcb03000 0x1000>;
>> +                     interrupts = <0 23 4>;
>> +                     clocks = <&uartclk3>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             uart4: uart at fcb04000 {
>> +                     compatible = "arm,pl011", "arm,primecell";
>> +                     reg = <0xfcb04000 0x1000>;
>> +                     interrupts = <0 24 4>;
>> +                     clocks = <&uartclk4>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disabled";
>> +             };
>> +
>> +             gpio0: gpio at fc806000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc806000 0x1000>;
>> +                     interrupts = <0 64 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 2 0 1 &pmx0 3 0 1 &pmx0 4 0 1
>> +                                     &pmx0 5 0 1 &pmx0 6 1 1 &pmx0 7 2 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk0>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio1: gpio at fc807000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc807000 0x1000>;
>> +                     interrupts = <0 65 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
>> +                                     &pmx0 3 3 1 &pmx0 4 3 1 &pmx0 5 4 1
>> +                                     &pmx0 6 5 1 &pmx0 7 6 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk1>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio2: gpio at fc808000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc808000 0x1000>;
>> +                     interrupts = <0 66 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 7 1 &pmx0 1 8 1 &pmx0 2 9 1
>> +                                     &pmx0 3 10 1 &pmx0 4 3 1 &pmx0 5 3 1
>> +                                     &pmx0 6 3 1 &pmx0 7 3 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk2>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio3: gpio at fc809000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc809000 0x1000>;
>> +                     interrupts = <0 67 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
>> +                                     &pmx0 3 3 1 &pmx0 4 11 1 &pmx0 5 11 1
>> +                                     &pmx0 6 11 1 &pmx0 7 11 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk3>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio4: gpio at fc80a000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80a000 0x1000>;
>> +                     interrupts = <0 68 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 11 1 &pmx0 1 11 1 &pmx0 2 11 1
>> +                                     &pmx0 3 11 1 &pmx0 4 12 1 &pmx0 5 12 1
>> +                                     &pmx0 6 13 1 &pmx0 7 13 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk4>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio5: gpio at fc80b000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80b000 0x1000>;
>> +                     interrupts = <0 69 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 14 1 &pmx0 1 15 1 &pmx0 2 16 1
>> +                                     &pmx0 3 16 1 &pmx0 4 16 1 &pmx0 5 16 1
>> +                                     &pmx0 6 16 1 &pmx0 7 16 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk5>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio6: gpio at fc80c000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80c000 0x1000>;
>> +                     interrupts = <0 70 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 16 1 &pmx0 1 16 1 &pmx0 2 17 1
>> +                                     &pmx0 3 17 1 &pmx0 4 18 1 &pmx0 5 18 1
>> +                                     &pmx0 6 18 1 &pmx0 7 19 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk6>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio7: gpio at fc80d000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80d000 0x1000>;
>> +                     interrupts = <0 71 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 19 1 &pmx0 1 20 1 &pmx0 2 21 1
>> +                                     &pmx0 3 22 1 &pmx0 4 23 1 &pmx0 5 24 1
>> +                                     &pmx0 6 25 1 &pmx0 7 26 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk7>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio8: gpio at fc80e000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80e000 0x1000>;
>> +                     interrupts = <0 72 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 27 1 &pmx0 1 28 1 &pmx0 2 29 1
>> +                                     &pmx0 3 30 1 &pmx0 4 31 1 &pmx0 5 32 1
>> +                                     &pmx0 6 33 1 &pmx0 7 34 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk8>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio9: gpio at fc80f000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc80f000 0x1000>;
>> +                     interrupts = <0 73 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 35 1 &pmx0 1 36 1 &pmx0 2 37 1
>> +                                     &pmx0 3 38 1 &pmx0 4 39 1 &pmx0 5 40 1
>> +                                     &pmx0 6 41 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk9>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio10: gpio at fc810000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc810000 0x1000>;
>> +                     interrupts = <0 74 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 2 43 1 &pmx0 3 44 1 &pmx0 4 45 1
>> +                                     &pmx0 5 45 1 &pmx0 6 46 1 &pmx0 7 46 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk10>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio11: gpio at fc811000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc811000 0x1000>;
>> +                     interrupts = <0 75 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 47 1 &pmx0 1 47 1 &pmx0 2 47 1
>> +                                     &pmx0 3 47 1 &pmx0 4 47 1 &pmx0 5 48 1
>> +                                     &pmx0 6 49 1 &pmx0 7 49 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk11>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio12: gpio at fc812000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc812000 0x1000>;
>> +                     interrupts = <0 76 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 49 1 &pmx0 1 50 1 &pmx0 2 49 1
>> +                                     &pmx0 3 49 1 &pmx0 4 51 1 &pmx0 5 51 1
>> +                                     &pmx0 6 51 1 &pmx0 7 52 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk12>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio13: gpio at fc813000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc813000 0x1000>;
>> +                     interrupts = <0 77 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 51 1 &pmx0 1 51 1 &pmx0 2 53 1
>> +                                     &pmx0 3 53 1 &pmx0 4 53 1 &pmx0 5 54 1
>> +                                     &pmx0 6 55 1 &pmx0 7 56 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk13>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio14: gpio at fc814000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc814000 0x1000>;
>> +                     interrupts = <0 78 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 57 1 &pmx0 1 97 1 &pmx0 2 97 1
>> +                                     &pmx0 3 58 1 &pmx0 4 59 1 &pmx0 5 60 1
>> +                                     &pmx0 6 60 1 &pmx0 7 61 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk14>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio15: gpio at fc815000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc815000 0x1000>;
>> +                     interrupts = <0 79 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 61 1 &pmx0 1 62 1 &pmx0 2 62 1
>> +                                     &pmx0 3 63 1 &pmx0 4 63 1 &pmx0 5 64 1
>> +                                     &pmx0 6 64 1 &pmx0 7 65 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk15>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio16: gpio at fc816000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc816000 0x1000>;
>> +                     interrupts = <0 80 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 66 1 &pmx0 1 67 1 &pmx0 2 68 1
>> +                                     &pmx0 3 69 1 &pmx0 4 70 1 &pmx0 5 71 1
>> +                                     &pmx0 6 72 1 &pmx0 7 73 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk16>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio17: gpio at fc817000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc817000 0x1000>;
>> +                     interrupts = <0 81 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 74 1 &pmx0 1 75 1 &pmx0 2 76 1
>> +                                     &pmx0 3 77 1 &pmx0 4 78 1 &pmx0 5 79 1
>> +                                     &pmx0 6 80 1 &pmx0 7 81 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk17>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio18: gpio at fc818000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc818000 0x1000>;
>> +                     interrupts = <0 82 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 82 1 &pmx0 1 83 1 &pmx0 2 83 1
>> +                                     &pmx0 3 84 1 &pmx0 4 84 1 &pmx0 5 85 1
>> +                                     &pmx0 6 86 1 &pmx0 7 87 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk18>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio19: gpio at fc819000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc819000 0x1000>;
>> +                     interrupts = <0 83 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 87 1 &pmx0 1 87 1 &pmx0 2 88 1
>> +                                     &pmx0 3 88 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk19>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio20: gpio at fc81a000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc81a000 0x1000>;
>> +                     interrupts = <0 84 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 0 89 1 &pmx0 1 89 1 &pmx0 2 90 1
>> +                                     &pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk20>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             gpio21: gpio at fc81b000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0xfc81b000 0x1000>;
>> +                     interrupts = <0 85 0x4>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = < &pmx0 3 94 1 &pmx0 7 96 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&gpioclk21>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "disable";
>> +             };
>> +
>> +             pmx0: pinmux at fc803000 {
>> +                     compatible = "pinctrl-single";
>> +                     reg = <0xfc803000 0x188>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     #gpio-range-cells = <3>;
>> +                     ranges;
>> +
>> +                     pinctrl-single,register-width = <32>;
>> +                     pinctrl-single,function-mask = <7>;
>> +                     /* pin base, nr pins & gpio function */
>> +                     pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1
>> +                                             &range 12 1 0 &range 13 29 1
>> +                                             &range 43 1 0 &range 44 49 1
>> +                                             &range 94 1 1 &range 96 2 1>;
>> +
>> +                     range: gpio-range {
>> +                             #pinctrl-single,gpio-range-cells = <3>;
>> +                     };
>> +             };
>> +
>> +             pmx1: pinmux at fc803800 {
>> +                     compatible = "pinconf-single";
>> +                     reg = <0xfc803800 0x2dc>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges;
>> +
>> +                     pinctrl-single,register-width = <32>;
>> +             };
>> +     };
>> +};
>> diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi4511.dts
>> new file mode 100644
>> index 0000000..746b8eb
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/hi4511.dts
>> @@ -0,0 +1,735 @@
>> +/*
>> + *  Copyright (C) 2012-2013 Linaro Ltd.
>> + *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  publishhed by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "hi3620.dtsi"
>> +
>> +/ {
>> +     model = "Hisilicon Hi4511 Development Board";
>> +     compatible = "hisilicon,hi3620-hi4511";
>> +
>> +     chosen {
>> +             bootargs = "console=ttyAMA0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on mem=512m earlyprintk";
>
> It probably doesn't make sense to specify your network and nfsroot
> parameters here, since they will differ from install environment to
> install enviroment.
>
> Also, mem=<x> isn't needed here since you ahve a proper memory node below.
>
OK

>> +     };
>> +
>> +     memory {
>> +             reg = <0x00000000 0x20000000>;
>> +     };
>> +
>> +     amba {
>> +             timer0: timer at fc800000 {
>> +                     status = "ok";
>> +             };
>> +
>> +             uart0: uart at fcb00000 {  /* console */
>> +                     pinctrl-names = "default", "idle";
>> +                     pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
>> +                     pinctrl-1 = <&uart0_pmx_idle &uart0_cfg_idle>;
>> +                     status = "ok";
>> +             };
>> +
>> +             uart1: uart at fcb01000 { /* modem */
>> +                     pinctrl-names = "default", "idle";
>> +                     pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
>> +                     pinctrl-1 = <&uart1_pmx_idle &uart1_cfg_idle>;
>> +                     status = "ok";
>> +             };
>> +
>> +             uart2: uart at fcb02000 { /* audience */
>> +                     pinctrl-names = "default", "idle";
>> +                     pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
>> +                     pinctrl-1 = <&uart2_pmx_idle &uart2_cfg_idle>;
>> +                     status = "ok";
>> +             };
>> +
>> +             uart3: uart at fcb03000 {
>> +                     pinctrl-names = "default", "idle";
>> +                     pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
>> +                     pinctrl-1 = <&uart3_pmx_idle &uart3_cfg_idle>;
>> +                     status = "ok";
>> +             };
>> +
>> +             uart4: uart at fcb04000 {
>> +                     pinctrl-names = "default", "idle";
>> +                     pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
>> +                     pinctrl-1 = <&uart4_pmx_idle &uart4_cfg_func>;
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio0: gpio at fc806000 {
>> +                     status = "ok";
>> +             };
>
> In general, only devices that are likely to not use on all boards are status
> = disable in the dtsi. For things like these gpio entries, are all boards
> expected to need to enable them anyway? if so, then it's just silly to mark
> them disabled in the dtsi.
>
OK

>
>> +             gpio-keys {
>> +                     compatible = "gpio-keys";
>> +
>> +                     call {
>> +                             label = "call";
>> +                             gpios = <&gpio17 2 0>;
>> +                             linux,code = <169>;     /* KEY_PHONE */
>> +                     };
>> +             };
>
> This doesn't really belong under the amba node. Please push to the top instead.
>
OK

>> +
>> +             pmx0: pinmux at fc803000 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&board_pmx_pins>;
>> +
>> +                     board_pmx_pins: board_pmx_pins {
>> +                             pinctrl-single,pins = <
>> +                                     0x008 0x0       /* GPIO -- eFUSE_DOUT */
>> +                                     0x100 0x0       /* USIM_CLK & USIM_DATA (IOMG63) */
>
> Please consider using the new preprocessor functions here instead of hardcoded
> hex values, if it makes sense for your platform -- I think it does?
>
> Also, it's nice when most of the pinctrl stuff can go in the dtsi file
> and keep the board file as clean as possible, since you ended up doing
> a lot of pinctrl entries in this board dts.
>
>
> -Olof

I don't like preprocessor functions here. Hardcoded hex values with comments is
simple & straightforward enough.

There're different pinmux configurations on different boards. So I
prefer them defined
in board dts file.

Regards
Haojian
