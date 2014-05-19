From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 19 May 2014 12:25:02 +0200
Subject: [PATCH RFC 3/4] clk: samsung: Add driver to control CLKOUT line
 on Exynos SoCs
In-Reply-To: <5379AFB9.9030608@linaro.org>
References: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
 <1400175151-27779-4-git-send-email-t.figa@samsung.com>
 <5379AFB9.9030608@linaro.org>
Message-ID: <5379DBFE.4010000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 19.05.2014 09:16, Tushar Behera wrote:
> On 05/15/2014 11:02 PM, Tomasz Figa wrote:
>> This patch introduces a driver that handles configuration of CLKOUT pin
>> of Exynos SoCs that can be used to output certain clocks from inside of
>> the SoC to a dedicated output pin.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
> 
> Tested the series on Exynos5420-based peach-pit board for audio playback
> (with an internal patch to set CLK_FIN_PLL as the parent of clkout).
> 
> Tested-by: Tushar Behera <tushar.behera@linaro.org>
> 

Thank you for testing.

>>  Example :
>>  pmu_system_controller: system-controller at 10040000 {
>>  	compatible = "samsung,exynos5250-pmu", "syscon";
>>  	reg = <0x10040000 0x5000>;
>> +	#clock-cells = <0>;
>> +	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
>> +			"clkout4", "clkout8", "clkout9";
>> +	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
>> +		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
>> +		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
>> +		<&clock CLK_XUSBXTI>;
>>  };
> 
> Adding an usage example in the documentation would be helpful.

Right, that's usually a good idea, I don't know why I haven't added one.
Thanks.

Best regards,
Tomasz
