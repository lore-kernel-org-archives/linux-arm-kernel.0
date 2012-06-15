From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 Jun 2012 10:32:37 +0200
Subject: [PATCH v3 7/9] arm: mach-mvebu: add compilation/configuration
 change
In-Reply-To: <20120615075644.GI26034@lunn.ch>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-8-git-send-email-gregory.clement@free-electrons.com>
 <20120615075644.GI26034@lunn.ch>
Message-ID: <4FDAF325.2080204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2012 09:56 AM, Andrew Lunn wrote:
> On Fri, Jun 15, 2012 at 09:44:08AM +0200, Gregory Clement wrote:
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
>> ---
>>  arch/arm/Kconfig  |   15 +++++++++++++++
>>  arch/arm/Makefile |    1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 23289d2..2ff9f40 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -533,6 +533,19 @@ config ARCH_IXP4XX
>>  	help
>>  	  Support for Intel's IXP4XX (XScale) family of processors.
>>  
>> +config ARCH_MVEBU
>> +	bool "Marvell SOCs with Device Tree support"
>> +	select CPU_V7
>> +	select GENERIC_CLOCKEVENTS
>> +	select MULTI_IRQ_HANDLER
>> +	select SPARSE_IRQ
>> +	select CLKSRC_MMIO
>> +	select GENERIC_IRQ_CHIP
>> +	select IRQ_DOMAIN
>> +	select COMMON_CLK
>> +	help
>> +	  Support for the Marvell SoC Family with device tree support
>> +
> 
> Hi Gregory
> 
> How is this going to work when we move DT supported kirkwood, Orion5x,
> Dove, etc into here?
> 
> Maybe this should be called ARCH_MVEBU_CPU_V7 for these two SoCs plus
> Dove and we have a second config ARCH_MVEBU_CPU_V5 for Kirkwood,
> Orion5x, MV78xx0?

I agree. Even at the arm level, the final goal will be to have
different kernels for ARM v4/5 and ARM v6/7.

> 
> 	 Andrew


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
