From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 22:02:27 +0900
Subject: [PATCH 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <d4ebd29f-98b7-6e56-42ee-923d55ca85ff@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-1-git-send-email-cw00.choi@samsung.com>
 <CGME20160816105140epcas1p22a27f424dd102a096a24df05640cefa3@epcas1p2.samsung.com>
 <d4ebd29f-98b7-6e56-42ee-923d55ca85ff@samsung.com>
Message-ID: <57B30EE3.1070606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 2016? 08? 16? 19:50, Sylwester Nawrocki wrote:
> Hi Chanwoo,
> 
> On 08/16/2016 08:35 AM, Chanwoo Choi wrote:
>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
>> Octa-core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
>> PSCI (Power State Coordination Interface) v0.1.
> 
>> ---
>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1580 ++++++++++++++++++++
> 
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi 
>> b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> new file mode 100644
>> index 000000000000..2a5b05744533
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> @@ -0,0 +1,1580 @@
> 
>> +
>> +/ {
>> +	compatible = "samsung,exynos5433";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
> 
>> +	soc: soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x0 0x18000000>;
> 
>> +		lpass: lpass at 11400000 {
>> +			compatible = "samsung,exynos5433-lpass";
>> +			reg = <0x11400000 0x100>;
>> +			samsung,pmu-syscon = <&pmu_system_controller>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2s0: i2s0 at 11440000 {
>> +			compatible = "samsung,exynos7-i2s";
>> +			reg = <0x11440000 0x100>;
>> +			dmas = <&adma 0 &adma 2>;
>> +			dma-names = "tx", "rx";
>> +			interrupts = <0 70 0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
>> +				 <&cmu_aud CLK_SCLK_AUD_I2S>,
>> +				 <&cmu_aud CLK_SCLK_I2S_BCLK>;
>> +			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&i2s0_bus>;
>> +			status = "disabled";
>> +		};
> 
>> +		serial_3: serial at 11460000 {
>> +			compatible = "samsung,exynos5433-uart";
>> +			reg = <0x11460000 0x100>;
>> +			interrupts = <0 67 0>;
>> +			clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
>> +				<&cmu_aud CLK_SCLK_AUD_UART>;
>> +			clock-names = "uart", "clk_uart_baud0";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&uart_aud_bus>;
>> +			status = "disabled";
>> +		};
>> +
> 
>> +		amba {
>> +			compatible = "arm,amba-bus";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
> 
>> +			adma: adma at 11420000 {
>> +				compatible = "arm,pl330", "arm,primecell";
>> +				reg = <0x11420000 0x1000>;
>> +				interrupts = <0 73 0>;
>> +				clocks = <&cmu_aud CLK_ACLK_DMAC>;
>> +				clock-names = "apb_pclk";
>> +				#dma-cells = <1>;
>> +				#dma-channels = <8>;
>> +				#dma-requests = <32>;
>> +			};
>> +		};
>> +	};
> 
> The latest Exynos5433 Audio Subsystem bindings look like this
> https://git.linuxtv.org/snawrocki/samsung.git/commit/?h=for-v4.9/mfd/exynos-lpass-v5&id=104cc6ad3ecc7c4c8ecf73663b93eb48b78f35aa
> i.e. adma at 11420000, i2s0 at 11440000, serial at 11460000 should be subnodes of
> the lpass at 11400000 node.

OK. I'll use your latest patches for sound and then test it again.

Regards,
Chanwoo Choi
