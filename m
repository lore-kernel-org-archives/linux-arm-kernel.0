From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 28 Mar 2013 09:57:05 +0100
Subject: [GIT PULL] at91: soc for 3.10 #2
In-Reply-To: <201303271902.00068.arnd@arndb.de>
References: <5152B357.3020500@atmel.com> <201303271902.00068.arnd@arndb.de>
Message-ID: <515405E1.1060105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 08:01 PM, Arnd Bergmann :
> On Wednesday 27 March 2013, Nicolas Ferre wrote:
> 
>> ----------------------------------------------------------------
>> Introduction of new Atmel Cortex-A5: SAMA5D3 family.
>> - Modify AT91 Kconfig to plit ARMv4/5 and ARMv7 arch
>> - Modify PMC driver (clocks)
>> - Core SAMA5 support
>> - Board file, DT files and defconfig
> 
> Looks really good. Olof said he'd take over merging tomorrow,
> so I'll leave it for him.
> 
>> ----------------------------------------------------------------
>> Ludovic Desroches (6):
>>       ARM: at91: change name template in AT91_SOC_START macro
>>       ARM: at91: add AT91_SAM9_TIME entry to select at91sam926x_time.c compilation
>>       ARM: at91: introduce the core type choice to split ARMv4/5 and ARMv7 arch
>>       ARM: at91: introduce SAMA5 support
>>       ARM: at91: dt: add device tree files for SAMA5D3 family
>>       ARM: at91: add defconfig for SAMA5
> 
> There is one obvious change that would be nice to include here,
> can you add this on top (either Nicolas or Olof)?

Yes, I include it in a v2 pull-request now.

Olof, can you please take this new one with Arnd's patch included?


> 8<---------
> Subject: ARM: at91: make ATAGS support conditional on CONFIG_ATAGS
> 
> We have the global CONFIG_ATAGS symbol that is used to determine
> whether ATAGS based boot is possible or not. Since we are
> splitting out the legacy boards from the main Kconfig on at91,
> we can use that symbol to easily hide the old options.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


Thanks, a lot, bye,


> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 0280238..119a0a4 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -137,8 +137,9 @@ config SOC_AT91SAM9N12
>  	  Select this if you are using Atmel's AT91SAM9N12 SoC.
>  
>  # ----------------------------------------------------------
> -
> +if ATAGS
>  source arch/arm/mach-at91/Kconfig.non_dt
> +endif
>  endif # SOC_SAM_V4_V5
>  
>  comment "Generic Board Type"
> 


-- 
Nicolas Ferre
