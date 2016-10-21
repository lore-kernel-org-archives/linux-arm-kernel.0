From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 21 Oct 2016 14:10:41 -0700
Subject: [PATCH v2 3/4] arm64: dts: msm8996: Add SMEM DT nodes
In-Reply-To: <20161021000408.GI26139@codeaurora.org>
References: <1477005139-15564-1-git-send-email-spjoshi@codeaurora.org>
 <1477005139-15564-4-git-send-email-spjoshi@codeaurora.org>
 <20161021000408.GI26139@codeaurora.org>
Message-ID: <52a996ef-a97c-3d6c-0a95-f9e3ebbd2790@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2016 05:04 PM, Stephen Boyd wrote:
> On 10/20, Sarangdhar Joshi wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Add SMEM and TCSR DT nodes on MSM8996.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 949b096..abc1089 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -164,17 +164,36 @@
>>
>>  	};
>>
>> +	tcsr_mutex: hwlock {
>> +		compatible = "qcom,tcsr-mutex";
>> +		syscon = <&tcsr_mutex_regs 0 0x1000>;
>> +		#hwlock-cells = <1>;
>> +	};
>> +
>>  	psci {
>>  		compatible = "arm,psci-1.0";
>>  		method = "smc";
>>  	};
>>
>> +	smem {
>> +		compatible = "qcom,smem";
>> +
>> +		memory-region = <&smem_mem>;
>> +
>> +		hwlocks = <&tcsr_mutex 3>;
>
> Super nitpick: Is there a reason we have newlines between
> everything in this node? This node is the only one that isn't
> consistent.

Thanks, will do that. I think I just missed updating this node from 
original patchset.

>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
