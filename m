From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Feb 2014 12:59:46 +0000
Subject: [PATCH 02/18] arm64: GICv3 device tree binding documentation
In-Reply-To: <loom.20140207T062553-254@post.gmane.org>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
 <loom.20140207T062553-254@post.gmane.org>
Message-ID: <52FCC1C2.1020203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnab,

On 07/02/14 05:41, Arnab Basu wrote:
> Hi Marc
> 
> Marc Zyngier <marc.zyngier <at> arm.com> writes:
> 
>> +
>> +AArch64 SMP cores are often associated with a GICv3, providing private
>> +peripheral interrupts (PPI), shared peripheral interrupts (SPI),
>> +software generated interrupts (SGI), and locality-specific peripheral
>> +Interrupts (LPI).
>> +
>> +Main node required properties:
>> +
>> +- compatible : should at least contain  "arm,gic-v3".
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. Must be a single cell with a value of at least 3.
>> +
>> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>> +  interrupts. Other values are reserved for future use.
> 
> These values are defined in
> "include/dt-bindings/interrupt-controller/arm-gic.h" maybe we should start
> mentioning that here and encourage future device treese to use those defines
> to improve readability.

It may improve readability, but it makes the definition rely on
something else. Definition and usage are two different things, and I
want the definition to be completely self-contained and non ambiguous.

In DTS files, people can use whatever macro they decide, and it is their
problem. They will even have out of tree DTS files, for which the
include file is not available.

> 
>> +
>> +  The 2nd cell contains the interrupt number for the interrupt type.
>> +  SPI interrupts are in the range [0-987]. PPI interrupts are in the
>> +  range [0-15].
>> +
>> +  The 3rd cell is the flags, encoded as follows:
>> +	bits[3:0] trigger type and level flags.
>> +		1 = edge triggered
>> +		2 = edge triggered (deprecated, for compatibility with GICv2)
>> +		4 = level triggered
>> +		8 = level triggered (deprecated, for compatibility with GICv2)
> 
> Similar to the above comment
> "include/dt-bindings/interrupt-controller/irq.h" defines the trigger type
> and level flags. Although this file currently contains the GICv2 bindings,
> we could update them.

Same as above.

Thanks for the review!

	M.
-- 
Jazz is not dead. It just smells funny...
