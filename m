From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 20 May 2016 21:09:55 +0800
Subject: [PATCH v2 3/3] ARM: dts: rockchip: fixes the spi compatible for
 rk3036
In-Reply-To: <28155403.nCsUkeXQB1@phil>
References: <1463702182-5188-1-git-send-email-wxt@rock-chips.com>
 <1463702182-5188-3-git-send-email-wxt@rock-chips.com>
 <8f662b3b-e359-efdf-72e5-c4f862dd1cf6@kernel-upstream.org>
 <28155403.nCsUkeXQB1@phil>
Message-ID: <3c1e174e-035b-78ae-b045-fe89990826da@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/5/20 20:58, Heiko Stuebner wrote:
> Am Freitag, 20. Mai 2016, 20:35:53 schrieb Shawn Lin:
>> ? 2016/5/20 7:56, Caesar Wang ??:
>>> That's seem the incorrect string to match the spi driver.
>>
>> Will it break the backward compatibility for some dtb if not
>> falling back to "rockchip,rockchip-spi" ?
>
> in what dtb did you see "rockchip,rockchip-spi"?

I'm not 100% sure, but I remember we toke this name on local
branch for rk3036 when we were developing this Soc.

> I.e. it isn't part of any current _mainline_ devicetree files.
>

Caesar, Could you check our develop-3.10 branch to see if it does
exist?

Anyway, "rockchip,rockchip-spi" isn't a part of mainline dt property.


>
> Heiko
>
>>
>>> Fixes commit f629fcfab2cd
>>> ("ARM: dts: rockchip: support the spi for rk3036")
>>>
>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: linux-rockchip at lists.infradead.org
>>>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>  arch/arm/boot/dts/rk3036.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/rk3036.dtsi
>>> b/arch/arm/boot/dts/rk3036.dtsi index d0f4bb7..a30700a 100644
>>> --- a/arch/arm/boot/dts/rk3036.dtsi
>>> +++ b/arch/arm/boot/dts/rk3036.dtsi
>>> @@ -431,7 +431,7 @@
>>>
>>>  	};
>>>  	
>>>  	spi: spi at 20074000 {
>>>
>>> -		compatible = "rockchip,rockchip-spi";
>>> +		compatible = "rockchip,rk3036-spi";
>>>
>>>  		reg = <0x20074000 0x1000>;
>>>  		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>>>  		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
>
>


-- 
Best Regards
Shawn Lin
