From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 20 May 2016 20:57:03 +0800
Subject: [PATCH v2 3/3] ARM: dts: rockchip: fixes the spi compatible for
 rk3036
In-Reply-To: <8f662b3b-e359-efdf-72e5-c4f862dd1cf6@kernel-upstream.org>
References: <1463702182-5188-1-git-send-email-wxt@rock-chips.com>
 <1463702182-5188-3-git-send-email-wxt@rock-chips.com>
 <8f662b3b-e359-efdf-72e5-c4f862dd1cf6@kernel-upstream.org>
Message-ID: <573F099F.1020603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2016?05?20? 20:35, Shawn Lin ??:
> ? 2016/5/20 7:56, Caesar Wang ??:
>> That's seem the incorrect string to match the spi driver.
>>
>
> Will it break the backward compatibility for some dtb if not
> falling back to "rockchip,rockchip-spi" ?

The rk3036 shouldn't work if you read the driver/spi/spi-rockchip.c.
since the "rockchip,rockchip-spi" is *not* exist in linux kernel.

..
  static const struct of_device_id rockchip_spi_dt_match[] = {
     { .compatible = "rockchip,rk3066-spi", },
     { .compatible = "rockchip,rk3188-spi", },
     { .compatible = "rockchip,rk3288-spi", },
     { .compatible = "rockchip,rk3399-spi", },
     { },
}
..


-Caesar

>
>> Fixes commit f629fcfab2cd
>> ("ARM: dts: rockchip: support the spi for rk3036")
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: linux-rockchip at lists.infradead.org
>>
>> ---
>>
>> Changes in v2: None
>>
>>  arch/arm/boot/dts/rk3036.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3036.dtsi 
>> b/arch/arm/boot/dts/rk3036.dtsi
>> index d0f4bb7..a30700a 100644
>> --- a/arch/arm/boot/dts/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rk3036.dtsi
>> @@ -431,7 +431,7 @@
>>      };
>>
>>      spi: spi at 20074000 {
>> -        compatible = "rockchip,rockchip-spi";
>> +        compatible = "rockchip,rk3036-spi";
>>          reg = <0x20074000 0x1000>;
>>          interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>>          clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
>>
>
>
>
>

-- 
caesar wang | software engineer | wxt at rock-chip.com
