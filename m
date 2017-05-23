From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 23 May 2017 19:20:18 +0800
Subject: [PATCH 06/12] arm64: dts: hi3660: add gpio dtsi file for
 Hisilicon Hi3660 SOC
In-Reply-To: <20170523004145.6y4x5n3leohrn7zc@rob-hp-laptop>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-7-guodong.xu@linaro.org>
 <20170523004145.6y4x5n3leohrn7zc@rob-hp-laptop>
Message-ID: <CAFGCpxxhs0HOfwdR=1kX9=4LSNrqryziQKTOqz8SEGveGO11oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 8:41 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, May 17, 2017 at 04:37:39PM +0800, Guodong Xu wrote:
>> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>>
>> This patch adds pl061 device nodes for Hi3660 SoC.
>>
>> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 409 ++++++++++++++++++++++++++++++
>>  1 file changed, 409 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index f217c9d..3bea0d2 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -251,5 +251,414 @@
>>                       clock-names = "uartclk", "apb_pclk";
>>                       status = "disabled";
>>               };
>> +
>> +             gpio0: gpio at e8a0b000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a0b000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 1 0 7>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO0>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>
> You don't need "ok" here if these are default enabled.
>
>> +             };
>> +
>> +             gpio1: gpio at e8a0c000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a0c000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 1 7 7>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO1>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>
> ditto...
>
>> +             };
>> +
>> +             gpio2: gpio at e8a0d000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a0d000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 14 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO2>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio3: gpio at e8a0e000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a0e000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 22 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO3>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio4: gpio at e8a0f000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a0f000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 30 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO4>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio5: gpio at e8a10000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a10000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 38 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO5>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio6: gpio at e8a11000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a11000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 46 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO6>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio7: gpio at e8a12000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a12000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 54 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO7>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio8: gpio at e8a13000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a13000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 62 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO8>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio9: gpio at e8a14000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a14000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 70 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO9>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio10: gpio at e8a15000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a15000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 78 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO10>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio11: gpio at e8a16000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a16000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 86 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO11>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio12: gpio at e8a17000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a17000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 94 3 &pmx0 7 101 1>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO12>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio13: gpio at e8a18000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a18000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 102 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO13>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio14: gpio at e8a19000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a19000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 110 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO14>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio15: gpio at e8a1a000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a1a000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx0 0 118 6>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO15>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio16: gpio at e8a1b000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a1b000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO16>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio17: gpio at e8a1c000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a1c000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO17>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio18: gpio at ff3b4000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xff3b4000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx2 0 0 8>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO18>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio19: gpio at ff3b5000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xff3b5000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx2 0 8 4>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO19>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio20: gpio at e8a1f000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a1f000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&pmx1 0 0 6>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO20>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio21: gpio at e8a20000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xe8a20000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     gpio-ranges = <&pmx3 0 0 6>;
>> +                     clocks = <&crg_ctrl HI3660_PCLK_GPIO21>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio22: gpio at fff0b000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xfff0b000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     /* GPIO176 */
>> +                     gpio-ranges = <&pmx4 2 0 6>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&sctrl HI3660_PCLK_AO_GPIO0>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +             gpio23: gpio at fff0c000 {
>> +                     compatible = "arm,pl061", "arm,primecell";
>> +                     reg = <0 0xfff0c000 0 0x1000>;
>> +                     interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     /* GPIO184 */
>> +                     gpio-ranges = <&pmx4 0 6 7>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     clocks = <&sctrl HI3660_PCLK_AO_GPIO1>;
>> +                     clock-names = "apb_pclk";
>> +                     status = "ok";
>> +             };
>> +
>> +              gpio24: gpio at fff0d000 {
>
> extra space     ^

Thanks, Rob. I will fix this and all above.
