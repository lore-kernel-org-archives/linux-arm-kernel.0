From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 17 Dec 2013 22:47:06 +0800
Subject: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property
 to the "altr,socfpga-gate-clk"
In-Reply-To: <52B0554F.1080509@gmail.com>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
 <1387213476-22122-2-git-send-email-dinguyen@altera.com>
 <52B00167.4010903@linaro.org> <52B0554F.1080509@gmail.com>
Message-ID: <52B063EA.4000800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/17/2013 09:44 PM, Dinh Nguyen wrote:
> Hi Zhangfei,
>
> On 12/17/13 1:46 AM, zhangfei wrote:
>>
>>
>> On 12/17/2013 01:04 AM, dinguyen at altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>>> +{
>>> +    struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
>>> +    struct regmap *sys_mgr_base_addr;
>>> +    u32 hs_timing;
>>> +
>>> +    if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>>> +        sys_mgr_base_addr =
>>> syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>>> +        if (IS_ERR(sys_mgr_base_addr)) {
>>> +            pr_err("%s: failed to find altr,sys-mgr regmap!\n",
>>> __func__);
>>> +            return -EINVAL;
>>> +        }
>>> +        hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
>>> +                        socfpgaclk->clk_phase[1]);
>>> +        regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
>>> +                        hs_timing);
>>> +    }
>>> +    return 0;
>>> +}
>>
>> So reusing gate-clk here and check the node of "altr,sys-mgr".
>> I think it is good and simple.
>> Also can define new clock combined with node "altr,sys-mgr" with
>> parent of sdmmc_clk.
>>
>> Thanks for the update, it is fine to me.
> Thanks, can I get an Ack from you for this version?
>

Sure, if it is helpful.

Thanks
