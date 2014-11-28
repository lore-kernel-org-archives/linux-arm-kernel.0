From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 28 Nov 2014 10:57:17 +0900
Subject: [03/19] clk: samsung: exynos5433: Add clocks using common clock
 framework
In-Reply-To: <54770FA2.9090804@samsung.com>
References: <1417073716-22997-4-git-send-email-cw00.choi@samsung.com>
 <54770FA2.9090804@samsung.com>
Message-ID: <5477D67D.2080407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 11/27/2014 08:48 PM, Pankaj Dubey wrote:
> Hi Chanwoo,
> 
> On Thursday 27 November 2014 01:05 PM, Chanwoo Choi wrote:
>> This patch adds the support for CMU (Clock Management Units) of Exynos5433
>> which is 64bit SoC and has Octa-cores. This patch supports necessary clocks
>> for kernel boot as following:
>> - PLL/MMC/UART/MCT/I2C/SPI
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
>>
>> ---
>> drivers/clk/samsung/Makefile           |   1 +
>>   drivers/clk/samsung/clk-exynos5433.c   | 971 +++++++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/exynos5433.h | 200 +++++++
>>   3 files changed, 1172 insertions(+)
>>   create mode 100644 drivers/clk/samsung/clk-exynos5433.c
>>   create mode 100644 include/dt-bindings/clock/exynos5433.h
>>

(snip)

>> +
>> +static struct samsung_div_clock top_div_clks[] __initdata = {
>> +    /* DIV_TOP2 */
>> +    DIV(CLK_DIV_ACLK_FSYS_200, "div_aclk_fsys_200", "mout_bus_pll_user",
>> +            DIV_TOP2, 0, 3),
>> +
>> +    /* DIV_TOP3 */
>> +    DIV(CLK_DIV_ACLK_IMEM_SSSX, "div_aclk_imem_sssx",
>> +            "mout_bus_pll_user", DIV_TOP3, 24, 3),
> 
> Isn't this clock name should be div_aclk_imem_sssx_266 as per UM?

You're right. So, I fxied clock name on patch11[1] for CMU_BUSx domains.
- [1] [PATCH 11/19] clk: samsung: exynos5433: Add clocks for CMU_BUS{0|1|2} domains

 	/* DIV_TOP3 */
-	DIV(CLK_DIV_ACLK_IMEM_SSSX, "div_aclk_imem_sssx",
+	DIV(CLK_DIV_ACLK_IMEM_SSSX_266, "div_aclk_imem_sssx_266",
 			"mout_bus_pll_user", DIV_TOP3, 24, 3),

Best Regards,
Chanwoo Choi
