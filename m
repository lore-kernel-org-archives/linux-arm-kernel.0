From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 2 Jan 2015 19:21:21 +0100
Subject: [PATCH 2/3] ARM: mediatek: add UART dts for mt8127 and mt8135
In-Reply-To: <CABuKBeJ-bBiJSbh9jKH1+T2MhKCjxnkryStrhG_kFX7HuBnevQ@mail.gmail.com>
References: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
 <1413983529-21887-3-git-send-email-eddie.huang@mediatek.com>
 <CABuKBeJ-bBiJSbh9jKH1+T2MhKCjxnkryStrhG_kFX7HuBnevQ@mail.gmail.com>
Message-ID: <CABuKBe+WeL7AOP0U9dtujUVr=cO2EDmz8rBSnscC9_LpxB7+yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-02 11:23 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> 2014-10-22 15:12 GMT+02:00 Eddie Huang <eddie.huang@mediatek.com>:
>> This add dts support for mt8127 and mt8135 SOC UART
>>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> ---
>>  arch/arm/boot/dts/mt8127.dtsi | 34 ++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/mt8135.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
>> index 25c9f69..249c218 100644
>> --- a/arch/arm/boot/dts/mt8127.dtsi
>> +++ b/arch/arm/boot/dts/mt8127.dtsi
>> @@ -64,6 +64,12 @@
>>                         clock-frequency = <32000>;
>>                         #clock-cells = <0>;
>>                 };
>> +
>> +               uart_clk: dummy26m {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <26000000>;
>> +                       #clock-cells = <0>;
>> +                };
>>         };
>>
>>         soc {
>> @@ -89,5 +95,33 @@
>>                               <0 0x10214000 0 0x2000>,
>>                               <0 0x10216000 0 0x2000>;
>>                 };
>> +
>> +               uart0: serial at 11006000 {
>> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11002000 0 0x400>;
>> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };

I just realized that you forgot to disable the uart ports by default
in the dtsi.
I fixed that for you, but please send a patch enabling the necessary
ports in the board dts file.
It depends on the board which uarts will be enabled rather then on the SoC.

>> +
>> +               uart1: serial at 11007000 {
>> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11003000 0 0x400>;
>> +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>> +               uart2: serial at 11008000 {
>> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11004000 0 0x400>;
>> +                       interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>> +               uart3: serial at 11009000 {
>> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11005000 0 0x400>;
>> +                       interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>>         };
>>  };
>> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
>> index 90a56ad..683b761 100644
>> --- a/arch/arm/boot/dts/mt8135.dtsi
>> +++ b/arch/arm/boot/dts/mt8135.dtsi
>> @@ -86,6 +86,13 @@
>>                         clock-frequency = <32000>;
>>                         #clock-cells = <0>;
>>                 };
>> +
>> +               uart_clk: dummy26m {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <26000000>;
>> +                       #clock-cells = <0>;
>> +               };
>> +
>>         };
>>
>>         soc {
>> @@ -111,5 +118,34 @@
>>                               <0 0x10214000 0 0x2000>,
>>                               <0 0x10216000 0 0x2000>;
>>                 };
>> +
>> +               uart0: serial at 11006000 {
>> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11006000 0 0x400>;
>> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>> +               uart1: serial at 11007000 {
>> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11007000 0 0x400>;
>> +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>> +               uart2: serial at 11008000 {
>> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11008000 0 0x400>;
>> +                       interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>> +               uart3: serial at 11009000 {
>> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>> +                       reg = <0 0x11009000 0 0x400>;
>> +                       interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&uart_clk>;
>> +               };
>> +
>>         };
>>  };
>> --
>> 1.8.1.1.dirty
>>
>
> Applied to v3.20-next/dts, thanks.
>
> --
> motzblog.wordpress.com



-- 
motzblog.wordpress.com
