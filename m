From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon, 19 Mar 2018 17:34:24 +0800
Subject: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
In-Reply-To: <20180318225029.GQ5626@tuxbook-pro>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
 <20180318225029.GQ5626@tuxbook-pro>
Message-ID: <45cba7ca-3a83-0ef8-eff7-a8b33bce9185@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 03/19/2018 06:50 AM, Bjorn Andersson wrote:
> On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> [..]
>> +Required properties:
>> +- compatible : contains the interconnect provider vendor specific compatible
>> +	       string
>> +- reg : register space of the interconnect controller hardware
> 
> These properties doesn't relate to the interconnect provider, so there's
> no need to describe them here.

Agree.

> 
>> +
>> +Examples:
>> +
>> +		snoc: snoc at 580000 {
> 
> These nodes should be described in a qcom/msm8916 binding document.

Ok, will move this and the above to the platform specific binding
documentation.

> 
>> +			compatible = "qcom,msm8916-snoc";
>> +			reg = <0x580000 0x14000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +			status = "okay";
>> +		};

Thanks for the comments!

BR,
Georgi
