From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 14 Nov 2016 23:05:55 +0800
Subject: [PATCH v2 1/9] arm64: dts: rockchip: add eMMC's power domain
 support for rk3399
In-Reply-To: <bce1a5eb-fbb3-9ed9-46b9-72a95eefed3e@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
 <1478697721-2323-2-git-send-email-wxt@rock-chips.com>
 <bce1a5eb-fbb3-9ed9-46b9-72a95eefed3e@rock-chips.com>
Message-ID: <5829D2D3.2050808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2016?11?12? 12:22, Shawn Lin wrote:
> On 2016/11/9 21:21, Caesar Wang wrote:
>> From: Ziyuan Xu <xzy.xu@rock-chips.com>
>>
>> Control power domain for eMMC via genpd to reduce power consumption.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> It was verified on my rk3399 evb with kernel4.4, so
> free feel to add my tag,
>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
>

Thanks the tests.

> BTW, it seems my reply is bounced form Yakir's address, so please
> remove him from CC list if he changed his mail address.

Right, Yakir's (ykk at rock-chips.com) address had left this world.;-)
But the patman tool is auto sending with the Cc people.

-
Caesar
>
>> ---
>>
>> Changes in v2:
>> - Reviewed-on: https://chromium-review.googlesource.com/376558
>> - Verified on ChromeOS kernel4.4
>>
>> arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index cbb7f8b..b401176 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -269,6 +269,7 @@
>> #clock-cells = <0>;
>> phys = <&emmc_phy>;
>> phy-names = "phy_arasan";
>> + power-domains = <&power RK3399_PD_EMMC>;
>> status = "disabled";
>> };
>>
>> @@ -690,6 +691,11 @@
>> status = "disabled";
>> };
>>
>> + qos_emmc: qos at ffa58000 {
>> + compatible = "syscon";
>> + reg = <0x0 0xffa58000 0x0 0x20>;
>> + };
>> +
>> qos_gmac: qos at ffa5c000 {
>> compatible = "syscon";
>> reg = <0x0 0xffa5c000 0x0 0x20>;
>> @@ -823,6 +829,11 @@
>> };
>>
>> /* These power domains are grouped by VD_LOGIC */
>> + pd_emmc at RK3399_PD_EMMC {
>> + reg = <RK3399_PD_EMMC>;
>> + clocks = <&cru ACLK_EMMC>;
>> + pm_qos = <&qos_emmc>;
>> + };
>> pd_gmac at RK3399_PD_GMAC {
>> reg = <RK3399_PD_GMAC>;
>> clocks = <&cru ACLK_GMAC>;
>>
>
>


-- 
caesar wang | software engineer | wxt at rock-chip.com
