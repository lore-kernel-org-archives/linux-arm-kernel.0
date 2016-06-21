From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Jun 2016 10:14:53 +0100
Subject: [PATCH 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <57687B08.9060900@codeaurora.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466452907-23290-2-git-send-email-srinivas.kandagatla@linaro.org>
 <57687B08.9060900@codeaurora.org>
Message-ID: <5769058D.9020008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/16 00:23, Stephen Boyd wrote:
> On 06/20/2016 01:01 PM, Srinivas Kandagatla wrote:
>> This patch adds apq8096 db820c basic support with serial port.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile            |  2 +-
>>   arch/arm64/boot/dts/qcom/apq8096-db820c.dts  | 21 +++++++++++++++++
>>   arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 34 ++++++++++++++++++++++++++++
>>   3 files changed, 56 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index fa1f661..80ecdfe 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -1,5 +1,5 @@
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
>> -dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb apq8096-db820c.dtb
>
> We should do a new line for each board as other arm64 vendors have done?
I agree, Will fix this in next version.

>
>> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>> new file mode 100644 >> +/dts-v1/;
>> +
>> +#include "apq8096-db820c.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. DB820c";
>> +	compatible = "qcom,apq8096-db820c";
>
> Should be qcom,apq8096-sbc? At least I have to use that on my board to
> match the board ids.
I agree, this should match up with the dtbTool. I have been manually 
patching up dtb to include the board-id, pmic id stuff.

I will fix it in next version,

Did not look at full details but, For some reason dtbTool does not 
support multiple compatible strings, do you think it makes sense to add 
this support in dtb tool to cope up with compatible strings like:

compatible = "qcom,apq8096-db820c", "qcom,apq8096-sbc";


Thanks,
srini
>
