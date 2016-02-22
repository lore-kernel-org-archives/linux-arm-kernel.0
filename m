From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Feb 2016 10:20:13 +0000
Subject: [PATCH v2 2/8] arm64: dts: qcom: apq8016-sbc: add usb support
In-Reply-To: <20160222055124.GG21240@tuxbot>
References: <1455104164-29356-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455104202-10560-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160222055124.GG21240@tuxbot>
Message-ID: <56CAE0DD.304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review,

On 22/02/16 05:51, Bjorn Andersson wrote:
> On Wed 10 Feb 03:36 PST 2016, Srinivas Kandagatla wrote:
>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 15 ++++++++++
>>   arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 35 ++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
>> index cbeee0b..4a79dd9 100644
>> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
>> @@ -10,4 +10,19 @@
>>   			output-low;
>>   		};
>>   	};
>> +
>> +	usb_id_default: usb_id_default {
>
> Labels are built with _, node names with -.
>
>> +		pinmux {
>> +			function = "gpio";
>> +			pins = "gpio121";
>> +		};
>
> You don't need a separate node to specify function...
>
>> +
>> +		pinconf {
>> +			pins = "gpio121";
>> +			function = "gpio";
>
> ...but if you really want it, then you shouldn't specify the function
> here.
Oops, Will remove this and resend the patch.
>
>> +			drive-strength = <8>;
>> +			input-enable;
>> +			bias-pull-up;
>> +		};
>> +	};
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> [..]
>> +
>> +	usb_id: usb-id {
>> +		interrupt-parent = <&msmgpio>;
>
> interrupt-parent is part of specifying an interrupt. You're not doing
> that here, so no need to specify a parent.
Yep, will clean this up in next version.
>
>> +		compatible = "linux,extcon-usb-gpio";
>> +		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usb_id_default>;
>>   	};
>>   };
>
> Apart from these two nits
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
srini
>
> Regards,
> Bjorn
>
