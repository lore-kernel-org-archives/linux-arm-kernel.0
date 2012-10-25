From: zonque@gmail.com (Daniel Mack)
Date: Thu, 25 Oct 2012 11:43:40 +0200
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <50889BB2.3090107@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com> <50889BB2.3090107@ti.com>
Message-ID: <508909CC.9000000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 25.10.2012 03:53, Jon Hunter wrote:
> 
> On 10/22/2012 02:55 PM, Daniel Mack wrote:

>> +Example for an AM33xx board:
>> +
>> +	gpmc: gpmc at 50000000 {
>> +		compatible = "ti,gpmc";
>> +		ti,hwmods = "gpmc";
>> +		reg = <0x50000000 0x1000000>;
> 
> Nit-pick, that size is quite large for a register range. I recommend
> looking at the HWMOD data file
> (arch/arm/mach-omap2/omap_hwmod_33xx_data.c) and see how much space is
> allocated for the registers (see structure am33xx_gpmc_addr_space).

Yeah but reserving the entire memory as per the reference manual also
prvents other from poking around in the same register space. Is there a
scenario in which it would of disadvantage to reserve all that memory?



Daniel
