From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 23 Jul 2015 14:06:28 +0530
Subject: [PATCH v6 08/13] clk: qcom: gdsc: Add GDSCs in msm8916 GCC
In-Reply-To: <55B03E34.1070508@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-9-git-send-email-rnayak@codeaurora.org>
 <55B03E34.1070508@codeaurora.org>
Message-ID: <55B0A78C.7030602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/23/2015 06:37 AM, Stephen Boyd wrote:
> On 07/22/2015 12:11 AM, Rajendra Nayak wrote:
>> @@ -2562,6 +2563,47 @@ static struct clk_branch gcc_venus0_vcodec0_clk
>> = {
>>       },
>>   };
>> +static struct gdsc venus_gdsc = {
>> +    .gdscr = 0x4c018,
>> +    .pd = {
>> +        .name = "venus",
>> +    },
>> +    .pwrsts = PWRDM_OFF_ON,
>> +};
>> +
>> +static struct gdsc mdss_gdsc = {
>> +    .gdscr = 0x4d078,
>> +    .pd = {
>> +        .name = "mdss",
>> +    },
>> +    .pwrsts = PWRDM_OFF_ON,
>> +};
>> +
>> +static struct gdsc jpeg_gdsc = {
>> +    .gdscr = 0x5701c,
>> +    .pd = {
>> +        .name = "jpeg",
>> +    },
>> +    .pwrsts = PWRDM_OFF_ON,
>> +};
>> +
>> +static struct gdsc vfe_gdsc = {
>> +    .gdscr = 0x58034,
>> +    .pd = {
>> +        .name = "vfe",
>> +    },
>> +    .pwrsts = PWRDM_OFF_ON,
>
> Is this supposed to tbe PWRSTS_OFF_ON?

indeed, will fix.
