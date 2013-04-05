From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Apr 2013 22:59:59 +0200
Subject: [PATCH v2 1/9] arm: mvebu: Limit the DMA zone when LPAE is
 selected
In-Reply-To: <201304052241.14865.arnd@arndb.de>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <1365193444-13441-2-git-send-email-gregory.clement@free-electrons.com>
 <201304052241.14865.arnd@arndb.de>
Message-ID: <515F3B4F.3070505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 10:41 PM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Gregory CLEMENT wrote:
>> When LPAE is activated on Armada XP, all registers and IOs are still
>> 32bit, the 40bit extension is on the CPU to DRAM path (windows) only.
>> That means that all the DMA transfer are restricted to the low 32 bits
>> address space. This is limitation is achieved by selecting ZONE_DMA.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> 
> Shouldn't that be ZONE_DMA32?
> 

Well common code for ARM don't manage the ZONE_DMA32. Whereas with
ZONE_DMA, setup_dma_zone() in arch/arm/mm/init.c does exactly what
I want: setting arm_dma_limit to 0xffffffff.

ZONE_DMA32 is used on arm64 however.

> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
