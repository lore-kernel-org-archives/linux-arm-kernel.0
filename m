From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 03 May 2016 19:48:24 +0900
Subject: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
In-Reply-To: <20160503102922.GD3956@kozik-lap>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <20160503102922.GD3956@kozik-lap>
Message-ID: <572881F8.3020701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 05? 03? 19:29, Krzysztof Kozlowski wrote:
> On Fri, Apr 15, 2016 at 03:32:47PM +0900, Chanwoo Choi wrote:
>> This patchset support the AMBA bus frequency scaling on Exynos5422-based
>> Odroid-XU3 board. But, this series only support the bus frequency scaling
>> for INT (Internal) block using VDD_INT power line.
>>
>> Also, to support the bus frequency scaling for Exynos542x SoC,
>> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
>> to measure the transfered data traffic on NoC (Network on Chip)
>> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
>> provide the utilization for INT block of Exynos542x SoC.
>>
>> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
>> device (drivers/devfreq/event/exynos-nocp.c) without any modification.
>> Just add the phandle of 'NoC Probe' dt node to bus dt node.
>>
>> Depend on:
>> This patchset depends on patch[1] which support the generic exynos-bus
>> frequency driver.
>> [1] http://www.spinics.net/lists/arm-kernel/msg495976.html
>> - [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor
>>
>>
>> Changse from v1:
>> (https://lkml.org/lkml/2016/4/8/28)
>> - Simplify the documentation of exynos-nocp.txt
>> - Check the return value of regmap function
>> - Modify Device Tree node name using general device name
>>  : nocp_memX_X@ nocp_memX_X -> nocp_memX_X@ nocp
>> - Fix wrong node name about nocp device tree node
>> - Drop the CLK_SET_RATE_PARENT flag
>> - Reorder bus device tree node alpabetically
>> - Add the tested-by tag from Anand Moon and Markus Reichl
>> - Add the reviewed-by tag to patch5/7 from Exynos SoC Maintainer
>> - Add patch2 to modify the devfreq_event_get_edev_by_phandle()
>>   to get the instance of devfreq-event device by using the phandle
>>
>> Chanwoo Choi (8):
>>   PM / devfreq: event: Add new Exynos NoC probe driver
>>   PM / devfreq: event: Find the instance of devfreq-event device by using phandle
>>   PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
>>   ARM: dts: Add NoC Probe dt node for Exynos542x SoC
>>   dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
>>   clk: samsung: exynos542x: Add the clock id for ACLK
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
>>   ARM: dts: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3
> 
> 
> Applied DTS patches for late v4.7 (hopefully).

Thanks for your review and apply.

Best Regards,
Chanwoo Choi
