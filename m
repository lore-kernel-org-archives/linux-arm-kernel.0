From: markz@nvidia.com (Mark Zhang)
Date: Thu, 8 Aug 2013 09:26:16 +0800
Subject: [PATCH 1/5] clk: tegra: Correct sbc mux width & parent
In-Reply-To: <52027C22.9080707@wwwdotorg.org>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
 <52027C22.9080707@wwwdotorg.org>
Message-ID: <5202F3B8.7010800@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 12:56 AM, Stephen Warren wrote:
> On 08/07/2013 05:25 AM, Mark Zhang wrote:
>> T114 sbc1-sbc6 have more possible parent clocks than t30.
>> So correct the parents and mux width for them.
> 
> s/T114/Tegra114/ s/t30/Tegra30/
> 

Got it.

>> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> 
>> -	TEGRA_INIT_DATA_MUX("sbc1", NULL, "tegra11-spi.0", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC1, 41, &periph_h_regs, TEGRA_PERIPH_ON_APB, sbc1),
> ...
>> +	TEGRA_INIT_DATA_MUX8("sbc1", NULL, "tegra11-spi.0", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_SBC1, 41, &periph_h_regs, TEGRA_PERIPH_ON_APB, sbc1),
> 
> This isn't a comment on this patch, but sometime later, can we remove
> those device names from these entries? They're wrong on many different
> levels, and shouldn't be required now that all our devices get clocks
> from DT.
> 

Correct. Actually they're useless if all drivers get their clocks via
DT. Just as you said, we can do it later and will rewrite all clock
declarations at that time.
