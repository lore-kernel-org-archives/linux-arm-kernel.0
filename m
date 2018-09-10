From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Tue, 11 Sep 2018 01:07:18 +0900
Subject: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoint of rk3328
In-Reply-To: <2729174.Cl53sqNc79@phil>
References: <20180906163956.20667-1-katsuhiro@katsuster.net>
 <2729174.Cl53sqNc79@phil>
Message-ID: <ba47e7c5-184c-caf7-2892-3610639d36eb@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2018?09?10? 22:57, Heiko Stuebner wrote:
> Hi,
> 
> Am Donnerstag, 6. September 2018, 18:39:56 CEST schrieb Katsuhiro Suzuki:
>> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
>> Because to use modern sound card interface such as audio-graph-card.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index d3ef6566325e..41f0a20b73ed 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -179,7 +179,13 @@
>>   		clock-names = "i2s_clk", "i2s_hclk";
>>   		dmas = <&dmac 11>, <&dmac 12>;
>>   		dma-names = "tx", "rx";
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		i2s0_p0: port at 0 {
> 
> there is only one port per device, so this should probably be
> 	i2s0_p0: port {
> without the address. Same for all others.
> The of-graph framework should work just fine then as well.

Thanks, indeed. I'll fix and send v2.


> 
> Heiko
> 
> 
> 

Regards,
--
Katsuhiro Suzuki
