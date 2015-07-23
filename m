From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 23 Jul 2015 11:04:14 -0700
Subject: [PATCH v6 01/13] clk: qcom: Add support for GDSCs
In-Reply-To: <55B0AF34.2000706@mm-sol.com>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-2-git-send-email-rnayak@codeaurora.org>
 <55B03495.8050902@codeaurora.org> <55B0AF34.2000706@mm-sol.com>
Message-ID: <55B12C9E.6070208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 02:09 AM, Stanimir Varbanov wrote:
> <snip>
>
>>
>> +
>> +void gdsc_unregister(struct device *dev)
>> +{
>> +    of_genpd_del_provider(dev->of_node);
>> +}
>> EXPORT_SYMBOL?
> Stephen, gdsc_register/unregister are internal to the qcom clk driver
> why to export them?
>

Ah, I thought this was being called from outside the clk-qcom.ko module. 
As long as we don't call them from a SoC specific driver then it should 
be ok to leave them unexported. Perhaps we should remove the export on 
qcom_find_freq() too?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
