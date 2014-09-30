From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 16:48:56 +0100
Subject: [PATCH v2 1/4] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <20140930151437.GM28481@sonymobile.com>
References: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1412086188-20940-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20140930151437.GM28481@sonymobile.com>
Message-ID: <542AD0E8.5030605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/09/14 16:14, Bjorn Andersson wrote:
> On Tue 30 Sep 07:09 PDT 2014, Srinivas Kandagatla wrote:
>
>> This patch adds rpm node to apq8064 dt as rpm would be used by other
>> devices for regulator support. Also adds all the regulators in the rpm.
>>
>
> Some comments on the compatibles, based on rpm-regulator-8960 msm-3.4.
>
Thanks for the review. I kind of grabbed a table from datasheet, 
obviously my interpretation of some of them are wrong. I should have 
looked at rpm-regulator-8960.c.

I will fix them in next version.

> After giving this some more thought I think it would be good to defer the
> voltage definition to the dts files, at least for the ldos (as these are being
> re-purposed).
>
I agree with you.
> That way the dts implementor will be the one frying their components and not us
> because some default value kicking in because someone miss-spelled or forgot to
> override a certain voltage.
>
Yes.. I had the same feeling when I started adding this.. But I wanted 
to send it for review and see.

>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064.dtsi | 297 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 297 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>
> [..]
>
>> +			pm8921_s5: pm8921-s5 {
>> +				compatible		= "qcom,rpm-pm8921-smps";
>
> qcom,rpm-pm8921-ftsmps
>
>> +				reg			= <QCOM_RPM_PM8921_SMPS5>;
>> +				regulator-min-microvolt	= < 850000>;
>> +				regulator-max-microvolt	= <1300000>;
>> +			};
>> +
>> +			pm8921_s6: pm8921-s6 {
>> +				compatible		= "qcom,rpm-pm8921-smps";
>
> qcom,rpm-pm8921-ftsmps
>
>> +				reg			= <QCOM_RPM_PM8921_SMPS6>;
>> +				regulator-min-microvolt	= < 850000>;
>> +				regulator-max-microvolt	= <1300000>;
>> +			};
>> +
>> +			pm8921_s7: pm8921-s7 {
>> +				compatible		= "qcom,rpm-pm8921-smps";
>> +				reg			= <QCOM_RPM_PM8921_SMPS7>;
>> +				regulator-min-microvolt	= < 500000>;
>> +				regulator-max-microvolt	= <1350000>;
>> +			};
>> +
>> +			pm8921_s8: pm8921-s8 {
>> +				compatible		= "qcom,rpm-pm8921-smps";
>> +				reg			= <QCOM_RPM_PM8921_SMPS8>;
>> +				regulator-min-microvolt	= <1500000>;
>> +				regulator-max-microvolt	= <2350000>;
>> +			};
>> +
>> +			/* PMOS LDO */
>> +			pm8921_l1: pm8921-l1 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo
>
>> +				reg			= <QCOM_RPM_PM8921_LDO1>;
>> +				regulator-min-microvolt	= <1000000>;
>> +				regulator-max-microvolt	= <1450000>;
>> +			};
>> +
>> +			pm8921_l2: pm8921-l2 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo
>
>> +				reg			= <QCOM_RPM_PM8921_LDO2>;
>> +				regulator-min-microvolt	= <1200000>;
>> +				regulator-max-microvolt	= <1200000>;
>> +			};
>> +
>
> [..]
>
>> +
>> +			pm8921_l24: pm8921-l24 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo1200
>
>> +				reg			= <QCOM_RPM_PM8921_LDO24>;
>> +				regulator-min-microvolt = <0750000>;
>> +				regulator-max-microvolt = <1250000>;
>> +			};
>> +
>> +			pm8921_l25: pm8921-l25 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo1200
>
>> +				reg			= <QCOM_RPM_PM8921_LDO25>;
>> +				regulator-min-microvolt = <0750000>;
>> +				regulator-max-microvolt = <1250000>;
>> +			};
>> +
>> +			pm8921_l26: pm8921-l26 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo1200
>
>> +				reg			= <QCOM_RPM_PM8921_LDO26>;
>> +				regulator-min-microvolt = <0750000>;
>> +				regulator-max-microvolt = <1250000>;
>> +			};
>> +
>> +			pm8921_l27: pm8921-l27 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo1200
>
>> +				reg			= <QCOM_RPM_PM8921_LDO27>;
>> +				regulator-min-microvolt = <0750000>;
>> +				regulator-max-microvolt = <1250000>;
>> +			};
>> +
>> +			pm8921_l28: pm8921-l28 {
>> +				compatible		= "qcom,rpm-pm8921-pldo";
>
> qcom,rpm-pm8921-nldo1200
>
>> +				reg			= <QCOM_RPM_PM8921_LDO28>;
>> +				regulator-min-microvolt = <0750000>;
>> +				regulator-max-microvolt = <1500000>;
>> +			};
>> +
>
> [..]
>
>> +
>
> 			pm8921_usb_switch: pm8921-usb-switch {
> 				compatible = "qcom,rpm-pm8921-switch";
> 				reg = <QCOM_RPM_USB_OTG_SWITCH>;
> 			};
>
> 			pm8921_hdmi_switch: pm8921-hdmi-switch {
> 				compatible = "qcom,rpm-pm8921-switch";
> 				reg = <QCOM_RPM_HDMI_SWITCH>;
> 			};
>
> 			pm8921_ncp: pm8921-ncp {
> 				compatible = "qcom,rpm-pm8921-ncp";
> 				reg = <QCOM_RPM_PM8921_NCP>;
> 			};
>> +		};
>> +
>>   		/* Temporary fixed regulator */
>>   		vsdcc_fixed: vsdcc-regulator {
>>   			compatible = "regulator-fixed";
>> --
>> 1.9.1
>>
