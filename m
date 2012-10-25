From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 25 Oct 2012 08:22:55 -0500
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <508909CC.9000000@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com> <50889BB2.3090107@ti.com>
 <508909CC.9000000@gmail.com>
Message-ID: <50893D2F.6080205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/25/2012 04:43 AM, Daniel Mack wrote:
> Hi Jon,
> 
> On 25.10.2012 03:53, Jon Hunter wrote:
>>
>> On 10/22/2012 02:55 PM, Daniel Mack wrote:
> 
>>> +Example for an AM33xx board:
>>> +
>>> +	gpmc: gpmc at 50000000 {
>>> +		compatible = "ti,gpmc";
>>> +		ti,hwmods = "gpmc";
>>> +		reg = <0x50000000 0x1000000>;
>>
>> Nit-pick, that size is quite large for a register range. I recommend
>> looking at the HWMOD data file
>> (arch/arm/mach-omap2/omap_hwmod_33xx_data.c) and see how much space is
>> allocated for the registers (see structure am33xx_gpmc_addr_space).
> 
> Yeah but reserving the entire memory as per the reference manual also
> prvents other from poking around in the same register space. Is there a
> scenario in which it would of disadvantage to reserve all that memory?

1. It chews up a large chunk of virtual memory space unnecessarily. For
   devices not using HIGHMEM and wish to use say 512MB of RAM, virtual
   memory space can be constrained.
2. We don't do that today probably because of #1.

Cheers
Jon
