From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 15 Aug 2014 10:26:11 -0500
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <c43739ed82a34f6eb2adbbe240e07c5d@DM2PR03MB317.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815102329.GB596@leverpostej>
 <c43739ed82a34f6eb2adbbe240e07c5d@DM2PR03MB317.namprd03.prod.outlook.com>
Message-ID: <0DC5667C-E45A-4781-9AE6-0C5E1C70F268@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2014, at 10:21 AM, arnab.basu at freescale.com wrote:

>>> 
>>> +	cpus {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <0>;
>>> +
>>> +		/* We have 4 clusters having 2 Cortex-A57 cores each */
>>> +		cpu at 0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a57";
>>> +			reg = <0x0 0x0>;
>>> +			enable-method = "spin-table";
>>> +			cpu-release-addr = <0x0 0x8000fff8>;
>>> +		};
>> 
>> I would strongly recommend having a unique cpu-release-addr for each CPU.
>> 
> 
> This is more of a place holder, we intend to patch this address from U-Boot
> and use individual release addresses for each CPU.

If you are going to patch it in u-boot, than why not just have u-boot add the property and drop it from here.

If you intend to keep it here, than make <0x0 0x0> and add a comment that says u-boot will fill it out

- k
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
