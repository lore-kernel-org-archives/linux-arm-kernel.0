From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 8 Oct 2013 10:48:24 +0800
Subject: [PATCH] clk: debugfs add clk_rate_fops with DEBUG
In-Reply-To: <20131007212904.7445.60382@quantum>
References: <1376875884-13459-1-git-send-email-zhangfei.gao@linaro.org>
 <1376890457-17871-1-git-send-email-zhangfei.gao@linaro.org>
 <20131007212904.7445.60382@quantum>
Message-ID: <CAMj5BkhH64QxHxotCkmWhh0OohmRqXtHc9UCE8vXwG0SG6PUyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 5:29 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Zhangfei Gao (2013-08-18 22:34:17)
>> clk_rate_fops is added to debug
>> 1. set_rate (e.g. PLL)
>> 2. Choose mux parent, since mux could choose parent accordingly when set_rate.
>>
>> Causion: set_rate can be called directly from user space
>>
>> Example:
>> sfc_mux have two parents: 24M and 200M
>>
>> cat clk_summary
>>    clock                        enable_cnt  prepare_cnt  rate
>> ---------------------------------------------------------------------
>>  osc24mhz                       3           3            24000000
>>     bpll_fout3                  0           0            200000000
>>        sfc_mux                  0           0            200000000
>>           sfc                   0           0            200000000
>>
>> cat osc24mhz/bpll/bpll_fout3/sfc_mux/sfc/clk_rate
>> 200000000
>>
>> echo 24000000 >  osc24mhz/bpll/bpll_fout3/sfc_mux/sfc/clk_rate
>> cat clk_summary
>>    clock                        enable_cnt  prepare_cnt  rate
>> ---------------------------------------------------------------------
>>  osc24mhz                       3           3            24000000
>>     sfc_mux                     0           0            24000000
>>        sfc                      0           0            24000000
>>     bpll_fout3                  0           0            200000000
>>
>> cat osc24mhz/sfc_mux/sfc/clk_rate
>> 24000000
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Thanks for the patch. It is trivial enough where I think we can leave it
> on the list and let developers apply it if they need it for debug. I
> don't want to merge it since it exposes hardware control to userspace
> and could be abused in a way that could damage a device.
>
> Regards,
> Mike
>

Thanks Mike

Understand the risk, it is fine.

Thanks
