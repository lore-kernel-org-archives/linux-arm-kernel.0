From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 07 Jun 2017 21:53:35 +0900
Subject: [PATCH] ARM: dts: rk1108: change to "max-frequency" from
 "clock-freq-min-max"
In-Reply-To: <CANbgqAS9_xUfbH6j1u6oM9h8nHAaWUm4Afg8baq4Wxm1vCqg9w@mail.gmail.com>
References: <CGME20170601044338epcas5p3c202667dad66dabd4f2ad866e8ad870e@epcas5p3.samsung.com>
 <20170601044336.5745-1-jh80.chung@samsung.com>
 <CANbgqAS9_xUfbH6j1u6oM9h8nHAaWUm4Afg8baq4Wxm1vCqg9w@mail.gmail.com>
Message-ID: <3ce2ba9f-5bb9-6a6c-212c-720e4a06a6fa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/06/2017 10:15 AM, Andy Yan wrote:
> Hi Jaehoon:
> 
> 
> 2017-06-01 12:43 GMT+08:00 Jaehoon Chung <jh80.chung@samsung.com>:
> 
>> "clock-freq-min-max" was deprecated. There is only using in rk1108.dtsi.
>> Use the "max-frequency" for removiing "clock-freq-min-max" in future.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  arch/arm/boot/dts/rk1108.dtsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>
>   This file now renamed to rv1108.dtsi as rockchip official named it as
> RV1108.
>    The rename patch now is in Heiko's linux-rockchip tree:v4.13 dts32,
> maybe you should rebase this patch on it.

Thanks for noticing this. After checking it, i will resend the patch.

Best Regards,
Jaehoon Chung

> 
> diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
>> index 1297924..a9b5293 100644
>> --- a/arch/arm/boot/dts/rk1108.dtsi
>> +++ b/arch/arm/boot/dts/rk1108.dtsi
>> @@ -174,7 +174,7 @@
>>
>>         emmc: dwmmc at 30110000 {
>>                 compatible = "rockchip,rk1108-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>> -               clock-freq-min-max = <400000 150000000>;
>> +               max-frequency = <150000000>;
>>                 clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>>                          <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> @@ -186,7 +186,7 @@
>>
>>         sdio: dwmmc at 30120000 {
>>                 compatible = "rockchip,rk1108-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>> -               clock-freq-min-max = <400000 150000000>;
>> +               max-frequency = <150000000>;
>>                 clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>>                          <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> @@ -198,7 +198,7 @@
>>
>>         sdmmc: dwmmc at 30130000 {
>>                 compatible = "rockchip,rk1108-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>> -               clock-freq-min-max = <400000 100000000>;
>> +               max-frequency = <100000000>;
>>                 clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>>                          <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> --
>> 2.10.2
>>
>>
> 
