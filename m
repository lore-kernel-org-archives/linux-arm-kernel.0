From: joelf@ti.com (Joel Fernandes)
Date: Mon, 25 Nov 2013 16:24:35 -0600
Subject: [PATCH 0/7] AES/DES hwmod data and dmtimer fix
In-Reply-To: <20131125221232.GV10023@atomide.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
 <20131125221232.GV10023@atomide.com>
Message-ID: <5293CE23.5080205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 04:12 PM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [131125 13:46]:
>> Here are patches adding hwmod for AES/DES crypto modules for OMAP4, DRA7 SoCs.
>>
>> Also included is a fix that disables POSTED mode when dmtimer is requested.
>>
>> Joel Fernandes (7):
>>   ARM: OMAP: hwmod: Add SYSC offsets for AES IP
>>   ARM: DRA7xx: hwmod: Add hwmod data for DES IP
>>   ARM: DRA7xx: hwmod: Add hwmod data for AES IP
>>   ARM: OMAP4: hwmod: Add hwmod data for AES IP
>>   ARM: OMAP4: hwmod: add hwmod data for DES IP
>>   ARM: OMAP: Disable POSTED mode for errata i103 and i767
>>   OMAP: AM33xx: hwmod: Correct AES module SYSC type
>>
>>  arch/arm/mach-omap2/omap_hwmod.h                   |  11 +++
>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   1 +
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 101 +++++++++++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  78 ++++++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_common_data.c       |  10 ++
>>  arch/arm/plat-omap/include/plat/dmtimer.h          |   5 +-
>>  6 files changed, 205 insertions(+), 1 deletion(-)
> 
> To me it seems we should wait on these until we have the clocks
> coming from device tree. That leaves out some parts of this
> patchset.
> 

Ok, sure. Let me see which parts can go in now till DT entries are available. If
it doesn't make sense to apply these now, I'll revise and post them again later
once clock data is merged.

thanks,

-Joel
