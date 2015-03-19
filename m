From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Mar 2015 17:53:01 -0700
Subject: [PATCH 1/3] mfd: devicetree: qcom_rpm: document IPQ8064 resources
In-Reply-To: <20141124103812.GG4241@x1>
References: <1416512485-7292-1-git-send-email-joshc@codeaurora.org>
 <1416512485-7292-2-git-send-email-joshc@codeaurora.org>
 <20141124103812.GG4241@x1>
Message-ID: <550A1DED.3070008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/14 02:38, Lee Jones wrote:
> On Thu, 20 Nov 2014, Josh Cartwright wrote:
>
>> The IPQ8064 SoC has several RPM-controlled resources, an NSS fabrick
>> clock and four regulator resources.  Provide definitions for them.
>>
>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 6 +++++-
>>  include/dt-bindings/mfd/qcom-rpm.h                 | 6 ++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
> For my own reference:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Lee, can you pick this patch up please?

>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
>> index 4264021..6d4e3ec 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
>> +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
>> @@ -12,6 +12,7 @@ frequencies.
>>  		    "qcom,rpm-apq8064"
>>  		    "qcom,rpm-msm8660"
>>  		    "qcom,rpm-msm8960"
>> +		    "qcom,rpm-ipq8064"
>>  
>>  - reg:
>>  	Usage: required
>> @@ -67,6 +68,7 @@ of valid subnodes that can operate on these resources.
>>  		    "qcom,rpm-pm8901-ftsmps"
>>  		    "qcom,rpm-pm8921-smps"
>>  		    "qcom,rpm-pm8921-ftsmps"
>> +		    "qcom,rpm-smb208"
>>  
>>  - reg:
>>  	Usage: required
>> @@ -76,7 +78,9 @@ of valid subnodes that can operate on these resources.
>>  		    QCOM_RPM_PM8058_SMPS0 - QCOM_RPM_PM8058_SMPS4,
>>  		    QCOM_RPM_PM8821_SMPS1 - QCOM_RPM_PM8821_SMPS2,
>>  		    QCOM_RPM_PM8901_SMPS0 - QCOM_RPM_PM8901_SMPS4,
>> -		    QCOM_RPM_PM8921_SMPS1 - QCOM_RPM_PM8921_SMPS8
>> +		    QCOM_RPM_PM8921_SMPS1 - QCOM_RPM_PM8921_SMPS8,
>> +		    QCOM_RPM_SMB208_S1a, QCOM_RPM_SMB208_S1b,
>> +		    QCOM_RPM_SMB208_S2a, QCOM_RPM_SMB208_S2b
>>  
>>  - bias-pull-down:
>>  	Usage: optional
>> diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
>> index 388a6f3..13a9d4b 100644
>> --- a/include/dt-bindings/mfd/qcom-rpm.h
>> +++ b/include/dt-bindings/mfd/qcom-rpm.h
>> @@ -141,6 +141,12 @@
>>  #define QCOM_RPM_SYS_FABRIC_MODE		131
>>  #define QCOM_RPM_USB_OTG_SWITCH			132
>>  #define QCOM_RPM_VDDMIN_GPIO			133
>> +#define QCOM_RPM_NSS_FABRIC_0_CLK		134
>> +#define QCOM_RPM_NSS_FABRIC_1_CLK		135
>> +#define QCOM_RPM_SMB208_S1a			136
>> +#define QCOM_RPM_SMB208_S1b			137
>> +#define QCOM_RPM_SMB208_S2a			138
>> +#define QCOM_RPM_SMB208_S2b			139
>>  
>>  /*
>>   * Constants used to select force mode for regulators.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
