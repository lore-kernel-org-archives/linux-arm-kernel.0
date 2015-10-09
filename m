From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 09 Oct 2015 09:42:22 +0100
Subject: [PATCH 4/4] arm64: dts: apq8016-sbc: enable spi buses on LS and HS
In-Reply-To: <5616B303.9030909@codeaurora.org>
References: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444303181-32574-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5616B303.9030909@codeaurora.org>
Message-ID: <56177DEE.1070405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/10/15 19:16, Stephen Boyd wrote:
> On 10/08/2015 04:19 AM, Srinivas Kandagatla wrote:
>> This patch enables spi buses on low speed and high speed expansion
>> connectors on DB410C
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
>> index 3581272..d872654 100644
>> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
>> @@ -92,11 +92,21 @@
>>   	status = "okay";
>>   };
>>
>> +&blsp_spi3 {
>> +	/* On High speed expansion */
>> +	status = "okay";
>> +};
>> +
>>   &blsp_i2c4 {
>>   	/* On High speed expansion */
>>   	status = "okay";
>>   };
>>
>> +&blsp_spi5 {
>> +	/* On Low speed expansion */
>> +	status = "okay";
>> +};
>> +
>>   &blsp_i2c6 {
>>   	/* On Low speed expansion */
>>   	status = "okay";
>
> We've been using absolute nodes to mark device nodes as status = "okay".
> Can we keep doing that here please?

Sure, I will re-spin a new version.

--srini
>
