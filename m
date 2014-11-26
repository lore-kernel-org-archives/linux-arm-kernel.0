From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Nov 2014 10:17:04 +0000
Subject: [PATCH v5 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <BY1PR0301MB1303F8B412AFF14129DA564E82700@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB13037E20B2B52E612A6EBC0182700@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB1303F8B412AFF14129DA564E82700@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <5475A8A0.2090405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/14 05:11, bhupesh.sharma at freescale.com wrote:
> Hi Marc,
> 
> [big snip..]
> 
>>
>>> +	timer {
>>> +		compatible = "arm,armv8-timer";
>>> + interrupts = <1 13 0x1>, /* Physical Secure PPI, edge triggered */
>>> + <1 14 0x1>, /* Physical Non-Secure PPI, edge triggered */
>>> +			     <1 11 0x1>, /* Virtual PPI, edge triggered */
>>> +			     <1 10 0x1>; /* Hypervisor PPI, edge triggered */
>>
>> Are you sure about this "edge triggered"? The A57 TRM suggests otherwise:
>>
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0488g/way1
>> 382454511590.html
>>
> 
> Actually I did read the TRM but was confused by the "edge triggered" conventions
> used by Juno ARMv8 DTSI (see [1]). I see other ARMv8 DTSI also using the "edge triggered"
> notion, so I was wondering if I am missing some A57 errata or these DTSI also need fixing.

Yeah, the Juno DT is wrong as well. Funny how only the wrong bits get
copied over and over... I'll get Juno fixed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
