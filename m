From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 11:04:21 +0530
Subject: [PATCH v5 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
In-Reply-To: <20180327171249.GI1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
 <20180327171249.GI1403@tuxbook-pro>
Message-ID: <591f7429-e574-f983-0cdd-45aa07d5c9b1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 3/27/2018 10:42 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
>> +
> 
> If this is the board and qcom-ipq4019-ap.dk04.1.dtsi is the platform
> file then the compatible should be here and not there. Also qcom,ipq4019
> is not an awesome compatible for a board file.
> 

 ok, agree. Will correct the compatible and move it here.

>> +	soc {
>> +		dma at 7984000 {
>> +			status = "ok";
>> +		};
>> +
>> +		qpic-nand at 79b0000 {
>> +			pinctrl-0 = <&nand_pins>;
>> +			pinctrl-names = "default";
>> +			status = "ok";
>> +		};
> 
> nand_pins defines the muxing and is defined in the other dtsi. So please
> move these pinctrl-* properties to the dtsi.
> 
> As long as the node is disabled the pinctrl state won't be applied
> anyways.
> 
> 
> If there are electrical properties that needs to be specified you can
> override the pinctrl state in the board specific file.
> 

 ok, understood. Will follow these conventions in rest of the places as well.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
