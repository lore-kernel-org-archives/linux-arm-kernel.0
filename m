From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 15 Dec 2017 16:17:48 -0800
Subject: [PATCH 3/3] arm64: dts: meson-axg: add new reset DT node
In-Reply-To: <04b96767-2412-7242-780c-f3e1e610a62b@baylibre.com> (Neil
 Armstrong's message of "Fri, 17 Nov 2017 14:08:35 +0100")
References: <20171110084659.31641-1-yixun.lan@amlogic.com>
 <04b96767-2412-7242-780c-f3e1e610a62b@baylibre.com>
Message-ID: <7hind77cgj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 10/11/2017 09:46, Yixun Lan wrote:
>> Add reset DT node for Amlogic's Meson-AXG SoC.
>> 
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index e0fb860e12c5..65945c6c8b65 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -123,6 +123,12 @@
>>  			#size-cells = <2>;
>>  			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
>>  
>> +			reset: reset-controller at 1004 {
>> +				compatible = "amlogic,meson-axg-reset";
>> +				reg = <0x0 0x01004 0x0 0x9c>;
>> +				#reset-cells = <1>;
>> +			};
>> +
>>  			uart_A: serial at 24000 {
>>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
>>  				reg = <0x0 0x24000 0x0 0x14>;
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.16/dt64,

Kevin
