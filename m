From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 26 Apr 2015 21:38:38 +0200
Subject: [PATCH v5 1/3] ARM: pxa: pxa_cplds: add lubbock and mainstone IO
In-Reply-To: <1430075422.2927.131.camel@x220> (Paul Bolle's message of "Sun,
 26 Apr 2015 21:10:22 +0200")
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
 <1429996403-13644-2-git-send-email-robert.jarzmik@free.fr>
 <1430075422.2927.131.camel@x220>
Message-ID: <87iocillxd.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle <pebolle@tiscali.nl> writes:

> On Sat, 2015-04-25 at 23:13 +0200, Robert Jarzmik wrote:
>> --- a/arch/arm/mach-pxa/Kconfig
>> +++ b/arch/arm/mach-pxa/Kconfig
>  
>> +config PXA_SYSTEMS_CPLDS
>> +	bool "Motherboard cplds"
>> +	def_bool ARCH_LUBBOCK || MACH_MAINSTONE
>
> Just
> 	default ARCH_LUBBOCK || MACH_MAINSTONE
>
> should be enough.
Actually this will become a tristate, and I'll take your "default"
suggestion. For v2.

>> +	select MFD_CORE
Ah this is an oversight now I see it. In the move from drivers/mfd to arch/arm I
forgot to remove this. For v2 also.

>> +	help
>> +	  This driver supports the Lubbock and Mainstone multifunction chip
>> +	  found on the pxa25x development platform system (Lubbock) and pxa27x
>> +	  development platform system (Mainstone). This IO board supports the
>> +	  interrupts handling, ethernet controller, flash chips, etc ...
>
>> --- a/arch/arm/mach-pxa/Makefile
>> +++ b/arch/arm/mach-pxa/Makefile
>  
>> +obj-$(CONFIG_PXA_SYSTEMS_CPLDS)	+= pxa_cplds_irqs.o
>
> PXA_SYSTEMS_CPLDS is a bool symbol, so pxa_cplds_irqs.o will never be
> part of a module, correct?
Euh no, this another mistake of mine, it should capable of being a module, to
enable the lubbock/mainstone generic device tree support. I'll fix that for v2
also.

I removed the below comments as the built-in is an error of mine.

Thanks for the review Paul.

Cheers.

-- 
Robert
