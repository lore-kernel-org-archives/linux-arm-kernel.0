From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Fri, 06 Sep 2013 09:58:37 -0700
Subject: [PATCHv2 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <97899226-465A-4B78-9FFD-B6B14136420B@codeaurora.org>
References: <1378425890-4225-1-git-send-email-rvaswani@codeaurora.org>
 <97899226-465A-4B78-9FFD-B6B14136420B@codeaurora.org>
Message-ID: <522A09BD.3090802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/6/2013 7:28 AM, Kumar Gala wrote:
> On Sep 5, 2013, at 7:04 PM, Rohit Vaswani wrote:
>
>> diff --git a/arch/arm/boot/dts/msm8974-db.dts b/arch/arm/boot/dts/msm8974-db.dts
>> new file mode 100644
>> index 0000000..74106a8
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/msm8974-db.dts
>> @@ -0,0 +1,7 @@
>> +/include/ "msm8974.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm MSM8974 Dragonboard";
>> +	compatible = "qcom,msm8974-db", "qcom,msm8974";
>> +};
>> +
>> diff --git a/arch/arm/boot/dts/msm8974.dtsi b/arch/arm/boot/dts/msm8974.dtsi
>> new file mode 100644
>> index 0000000..aa3bb2f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/msm8974.dtsi
>> @@ -0,0 +1,30 @@
>> +/dts-v1/;
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm MSM8974";
>> +	compatible = "qcom,msm8974";
>> +	interrupt-parent = <&intc>;
>> +
>> +	soc: soc { };
>> +};
>> +
>> +&soc {
> We should probably have:
>
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges;
>          compatible = "simple-bus";

Sure. Not sure how that got left off.
>
>> +	intc: interrupt-controller at f9000000 {
>> +		compatible = "qcom,msm-qgic2";
>> +		interrupt-controller;
>> +		#interrupt-cells = <3>;
>> +		reg = < 0xf9000000 0x1000 >,
>> +		      < 0xf9002000 0x1000 >;
>> +	};
>> +
> Let's be consistent on white space around < >

Done.

>
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupts = <1 2 0xf08>,
>> +			     <1 3 0xf08>,
>> +			     <1 4 0xf08>,
>> +			     <1 1 0xf08>;
>> +		clock-frequency = <19200000>;
>> +	};
>
>
>> +};


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
