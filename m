From: rjui@broadcom.com (Ray Jui)
Date: Wed, 10 Dec 2014 17:37:03 -0800
Subject: [PATCH 1/4] pci: iProc: define Broadcom iProc PCIe binding
In-Reply-To: <1418207427.7616.5.camel@pengutronix.de>
References: <Ray Jui <rjui@broadcom.com>	
 <1418169871-19232-1-git-send-email-rjui@broadcom.com>	
 <1418169871-19232-2-git-send-email-rjui@broadcom.com>
 <1418207427.7616.5.camel@pengutronix.de>
Message-ID: <5488F53F.5060805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/10/2014 2:30 AM, Lucas Stach wrote:
>> +Example:
>> +
>> +SoC specific DT Entry:
>> +
>> +	pcie0: pcie at 18012000 {
>> +		compatible = "brcm,iproc-pcie";
>> +		reg = <0x18012000 0x1000>,
>> +			<0x18002000 0x1000>;
>> +		interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
>> +			     <GIC_SPI 97 IRQ_TYPE_NONE>,
>> +			     <GIC_SPI 98 IRQ_TYPE_NONE>,
>> +			     <GIC_SPI 99 IRQ_TYPE_NONE>,
>> +			     <GIC_SPI 100 IRQ_TYPE_NONE>,
>> +			     <GIC_SPI 101 IRQ_TYPE_NONE>;
>
> This is missing the interrupt-map and interrupt-map-mask for the legacy
> INTx interrupts. If you add this you don't need to have a special map
> function in your driver, but can just use the standard
> of_irq_parse_and_map_pci() function.
>
> Regards,
> Lucas
>
Thanks for pointing this out. I will look into this and try it out.
