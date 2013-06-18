From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 18 Jun 2013 16:23:58 -0400
Subject: [PATCHv3 2/6] arm: introduce config HAS_BANDGAP
In-Reply-To: <20130612170733.GK8164@atomide.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-3-git-send-email-eduardo.valentin@ti.com>
 <20130612170733.GK8164@atomide.com>
Message-ID: <51C0C1DE.70602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-06-2013 13:07, Tony Lindgren wrote:
> * Eduardo Valentin <eduardo.valentin@ti.com> [130607 13:53]:
>> Bandgap is a device used to measure temperature on
>> electronic equipments. It is widely used in digital
>> integrated circuits. It is based on the dependency
>> between silicon voltage and temperature.
>>
>> This patch introduce HAS_BANDGAP config entry.
>> This config is a boolean value so that arch
>> code can flag if they feature a bandgap device.
>>
>> This config entry follows the same idea behind
>> ARCH_HAS_CPUFREQ.
> 
> I suggest you add this to Russell's patch system:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks!

I have add it to Russell's patch system and it has been accepted and
applied.

>  
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-omap at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: Fabio Stevam <festevam@gmail.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  arch/arm/Kconfig            | 3 +++
>>  arch/arm/mach-omap2/Kconfig | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index d423d58..bcbdec9 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -174,6 +174,9 @@ config ARCH_HAS_CPUFREQ
>>  	  and that the relevant menu configurations are displayed for
>>  	  it.
>>  
>> +config ARCH_HAS_BANDGAP
>> +	bool
>> +
>>  config GENERIC_HWEIGHT
>>  	bool
>>  	default y
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index f49cd51..8620ab5 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -4,6 +4,7 @@ config ARCH_OMAP
>>  config ARCH_OMAP2PLUS
>>  	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
>>  	select ARCH_HAS_CPUFREQ
>> +	select ARCH_HAS_BANDGAP
>>  	select ARCH_HAS_HOLES_MEMORYMODEL
>>  	select ARCH_OMAP
>>  	select ARCH_REQUIRE_GPIOLIB
>> -- 
>> 1.8.2.1.342.gfa7285d
>>
> 
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/c73595f0/attachment.sig>
