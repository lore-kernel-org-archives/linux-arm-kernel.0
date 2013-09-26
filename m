From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu, 26 Sep 2013 11:05:45 -0700
Subject: [PATCHv4 2/3] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <B0F416B8-042A-49F1-81E9-B217F02AAD1E@codeaurora.org>
References: <1379992406-3541-1-git-send-email-rvaswani@codeaurora.org>
 <1379992406-3541-2-git-send-email-rvaswani@codeaurora.org>
 <4E7868D6-56CB-4AF8-8EBF-069966899C23@codeaurora.org>
 <5243652F.7090408@codeaurora.org>
 <B0F416B8-042A-49F1-81E9-B217F02AAD1E@codeaurora.org>
Message-ID: <52447779.3010908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/2013 9:37 AM, Kumar Gala wrote:
> <snip>

> +++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> @@ -0,0 +1,6 @@
> +/include/ "qcom-msm8974.dtsi"
> +
> +/ {
> +	model = "Qualcomm APQ8074 Dragonboard";
> +	compatible = "qcom,apq8074-dragonboard", "qcom,apq8074";
> +};
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> new file mode 100644
> index 0000000..f04b643
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -0,0 +1,35 @@
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "Qualcomm MSM8974";
> +	compatible = "qcom,msm8974";
> +	interrupt-parent = <&intc>;
> +
> +	soc: soc { };
>>> We should have a unit address here:
>>>
>>> 	  soc: soc at FOOBAR {
>>>
>>> also, split out the curly braces so any future patches do have to muck with that.
>>>
>>> 	};
>>>
>> Im not sure I understand the reasoning behind the unit address for soc ?
> Its fairly standard practice and there is a fair amount of discussion about the lack of a unit address for memory nodes.
>
That still doesn't really answer anything :) - and I couldn't find any 
discussions about this either.
I don't see anybody in upstream adding an address to soc except sun.
What is that address supposed to be for - what does it mean ?
The soc is way of encapsulating meaningful blocks  for the particular SoC.

>
>>>> +};
>>>> +
>>>> +&soc {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <1>;
>>>> +	ranges;
>>>> +	compatible = "simple-bus";
>>>> +
>>>> +	intc: interrupt-controller at f9000000 {
>>>> +		compatible = "qcom,msm-qgic2";
>>>> +		interrupt-controller;
>>>> +		#interrupt-cells = <3>;
>>>> +		reg = <0xf9000000 0x1000>,
>>>> +		      <0xf9002000 0x1000>;
>>>> +	};
>>>> +
>>>> +	timer {
>>>> +		compatible = "arm,armv7-timer";
>>>> +		interrupts = <1 2 0xf08>,
>>>> +			     <1 3 0xf08>,
>>>> +			     <1 4 0xf08>,
>>>> +			     <1 1 0xf08>;
>>>> +		clock-frequency = <19200000>;
>>>> +	};
>>>> +};
> - k
>


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
