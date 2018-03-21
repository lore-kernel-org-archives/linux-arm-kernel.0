From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 20 Mar 2018 23:09:02 -0500
Subject: [PATCHv6 3/3] clk: socfpga: stratix10: add clock driver for
 Stratix10 platform
In-Reply-To: <152148346040.242365.18406406194344107023@swboyd.mtv.corp.google.com>
References: <1519656455-14629-1-git-send-email-dinguyen@kernel.org>
 <1519656455-14629-3-git-send-email-dinguyen@kernel.org>
 <152148346040.242365.18406406194344107023@swboyd.mtv.corp.google.com>
Message-ID: <f0d3fc46-5fa1-4e77-ef73-284bf2ee0d61@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/19/2018 01:17 PM, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2018-02-26 06:47:35)
>> diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
>> index 9146c20..87ef977 100644
>> --- a/drivers/clk/socfpga/Makefile
>> +++ b/drivers/clk/socfpga/Makefile
>> @@ -1,6 +1,11 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> +ifeq ($(CONFIG_ARCH_SOCFPGA),y)
> 
> Ugh, any chance to make this better if we get three?
> 

I'll try.

...

> 
>> +{
>> +       struct stratix10_clock_data *clk_data;
>> +
>> +       clk_data = __socfpga_s10_clk_init(node, STRATIX10_NUM_CLKS);
>> +       if (!clk_data)
>> +               return;
>> +
>> +       s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
>> +
>> +       s10_clk_register_c_perip(s10_main_perip_c_clks,
>> +                                ARRAY_SIZE(s10_main_perip_c_clks), clk_data);
>> +
>> +       s10_clk_register_cnt_perip(s10_main_perip_cnt_clks,
>> +                                  ARRAY_SIZE(s10_main_perip_cnt_clks),
>> +                                  clk_data);
>> +
>> +       s10_clk_register_gate(s10_gate_clks, ARRAY_SIZE(s10_gate_clks),
>> +                             clk_data);
>> +}
>> +
>> +CLK_OF_DECLARE(stratix10_clock, "intel,stratix10-clkmgr", socfpga_s10_init);
> 
> Can it be a platform device? We prefer those over the CLK_OF_DECLARE
> style.
> 

Thanks for the review! I'll change it to a platform device and address
your other comments in v7.

Dinh
