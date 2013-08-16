From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 16 Aug 2013 11:43:36 -0500
Subject: [PATCH v1 03/14] clk: Add of_clk_match() for device drivers
In-Reply-To: <20130815050226.4443.39100@quantum>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-4-git-send-email-sboyd@codeaurora.org>
 <20130812202347.5348.76490@quantum> <20130813054839.GF14845@codeaurora.org>
 <20130815050226.4443.39100@quantum>
Message-ID: <0181ACFD-4F25-493C-9143-E197C53282DF@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2013, at 12:02 AM, Mike Turquette wrote:

>> Right now we have
>> 
>>        pll8: pll8 {
>>                #clock-cells = <0>;
>>                compatible = "qcom,pll";
>>                clocks = <&pxo>;
>>        };
>> 
>> in DT and
>> 
>>        static struct pll_desc pll8_desc = {
>>                .l_reg = 0x3144,
>>                .m_reg = 0x3148,
>>                .n_reg = 0x314c,
>>                .config_reg = 0x3154,
>>                .mode_reg = 0x3140,
>>                .status_reg = 0x3158,
>>                .status_bit = 16,
>>        };
>> 
>> in C. Do you want everything to be in DT? Something like:
>> 
>>        pll8: pll8 at 3140 {
>>                #clock-cells = <0>;
>>                compatible = "qcom,pll";
>>                clocks = <&pxo>;
>>                reg = <0x3140 0x20>;
>>        };
>> 
>> and then assume that all those registers are offset from the base
>> register and that the status bit is 16 (it usually is but not
>> always)?

I think its reasonable to put the various regs associated with a clock in the .dts like the example you show, but we should be going down to bit level details.  If we think of each clock as its own device its reasonable that the clock would have some set of registers associated with it.

-k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
