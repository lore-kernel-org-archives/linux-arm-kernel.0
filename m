From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 18 Feb 2016 10:25:01 +0000
Subject: [PATCH v2 1/8] arm64: Introduce Allwinner SoC config option
In-Reply-To: <20160218113207.5ffffee2@xhacker>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
 <1455709440-8668-2-git-send-email-andre.przywara@arm.com>
 <20160218113207.5ffffee2@xhacker>
Message-ID: <56C59BFD.20609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/02/16 03:32, Jisheng Zhang wrote:
> Dear Andre,
> 
> On Wed, 17 Feb 2016 11:43:53 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> To prepare for the Allwinner A64 SoC support, introduce a config
>> option to allow compiling Allwinner (aka. sunxi) specific drivers
>> for the arm64 architecture as well.
>> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
>> specific drivers to be selected during kernel configuration.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/Kconfig.platforms | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 8a09522..2f7f69b 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -1,5 +1,10 @@
>>  menu "Platform selection"
>>  
>> +config ARCH_SUNXI
> 
> it's better to keep ARCH_YYZZ sorted in alphabetic order

Right, I think I originally started with ARCH_ALLWINNER until I found
ARCH_SUNXI, but forgot to move it.
Actually I wonder if we should sort for the user visible config options
instead, but that's another story.

Cheers,
Andre.

> Thanks,
> Jisheng
> 
>> +	bool "Allwinner sunxi 64-bit SoC Family"
>> +	help
>> +	  This enables support for Allwinner sunxi based SoCs like the A64.
>> +
>>  config ARCH_BCM_IPROC
>>  	bool "Broadcom iProc SoC Family"
>>  	help
> 
