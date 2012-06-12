From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jun 2012 14:56:57 +0200
Subject: [PATCH v2 2/8] arm: mach-mvebu: add source files
In-Reply-To: <201206120845.48902.arnd@arndb.de>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-3-git-send-email-gregory.clement@free-electrons.com>
 <201206120845.48902.arnd@arndb.de>
Message-ID: <4FD73C99.6070908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:45 AM, Arnd Bergmann wrote:
> On Monday 11 June 2012, Gregory CLEMENT wrote:
>> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
>> new file mode 100644
>> index 0000000..72d39e5
>> --- /dev/null
>> +++ b/arch/arm/mach-mvebu/Kconfig
>> @@ -0,0 +1,7 @@
>> +if ARCH_MVEBU
>> +
>> +menu "Marvell SOC with device tree"
>> +
>> +endmenu
>> +
>> +endif
>
> The "with device tree" part is implied here, so you should not need to
> mention it, but it would be good if you could say which SOC this
> relates to, i.e. not the pxa/mmp series but the other line, in whatever
> way you want to name it.

Do you mean to name all the SOC aimed to be supported ?
and write something like that:

menu "Marvell SOC from EBU division (Orion, Kirkwood, Dove, MV78xx0,
Armada 370/XP, ...)"

Or for now just the currently supported SOC ? :
menu "Marvell SOC from EBU division (Armada 370, Armada XP, ...)"


>
>> +static struct map_desc mvebu_io_desc[] __initdata = {
>> +	{
>> +		.virtual	= MVEBU_REGS_VIRT_BASE,
>> +		.pfn		= __phys_to_pfn(MVEBU_REGS_PHYS_BASE),
>> +		.length		= MVEBU_REGS_SIZE,
>> +		.type		= MT_DEVICE,
>> +	},
>> +};
>> +
>> +void __init mvebu_map_io(void)
>> +{
>> +	iotable_init(mvebu_io_desc, ARRAY_SIZE(mvebu_io_desc));
>> +}
>
> It looks like MVEBU_REGS_PHYS_BASE is common between Armada XP and
> Armada 370, but is different for the other ones we want to support
> here (kirkwood, orion5x, mv78xx0, dove), so the name seems to be
> inappropriate. I would recommend dropping the entire file and just
> leaving the map_desc in the individual soc specific files, even
> thouth that means you have two identical calls here.

OK I will drop common.* files. We will see later to introduce them
again when we find common features with the other SOC.

>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
