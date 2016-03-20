From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sun, 20 Mar 2016 09:44:19 +0100
Subject: [PATCH V2 3/4] ARM: dts: imx6ul: Add GPMI nand controller support
In-Reply-To: <20160222092613.3c32a4a0@ipc1.ka-ro>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-4-git-send-email-michael@amarulasolutions.com>
 <CAOMZO5DTmG7Umt+H20r+tZi9zZhsK=eoPbHOBO3iwvM2GXXLgg@mail.gmail.com>
 <20160220172127.GC24064@panicking>
 <20160221112949.GB5387@panicking>
 <20160222092613.3c32a4a0@ipc1.ka-ro>
Message-ID: <CAOf5uwkn6k1YfMkMMSksKjakpP-NXsU0G9x0dyBao7n7NXSYug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar

On Mon, Feb 22, 2016 at 9:26 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> On Sun, 21 Feb 2016 12:29:53 +0100 Michael Trimarchi wrote:
>> Add support for GPMI nand controller.
>>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>> Changes V2:
>>       - drop special IMXUL type because seems that is compatible
>>         with IMX6Q
>>
>>  arch/arm/boot/dts/imx6ul.dtsi | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
>> index f4daf97..1a486ac 100644
>> --- a/arch/arm/boot/dts/imx6ul.dtsi
>> +++ b/arch/arm/boot/dts/imx6ul.dtsi
>> @@ -142,6 +142,39 @@
>>                       reg = <0x00900000 0x20000>;
>>               };
>>
>> +             dma_apbh: dma-apbh at 01804000 {
>> +                     compatible = "fsl,imx6ul-dma-apbh", "fsl,imx28-dma-apbh";
>> +                     reg = <0x01804000 0x2000>;
>> +                     interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
>> +                     #dma-cells = <1>;
>> +                     dma-channels = <4>;
>> +                     clocks = <&clks IMX6UL_CLK_APBHDMA>;
>> +             };
>> +
>> +             gpmi: gpmi-nand at 01806000 {
>> +                     compatible = "fsl,imx6q-gpmi-nand";
>>
> You should still add an imx6ul specific compatible (likewise to the
> dma_apbh).
>

I understand your point but this seems that imx6q and imx6sx are
defined in the same way

Michael

>
>
> Lothar Wa?mann



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
