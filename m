From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 22:24:58 +0100
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <20151207211656.GZ8644@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 7 Dec 2015 21:16:56 +0000")
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
 <87r3iy9er5.fsf@free-electrons.com>
 <87mvtm9ejc.fsf@free-electrons.com>
 <87d1ui9da0.fsf@free-electrons.com>
 <20151207211656.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <878u569ck5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On lun., d?c. 07 2015, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Dec 07, 2015 at 10:09:27PM +0100, Gregory CLEMENT wrote:
>> Hi Russell,
>>  
>>  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> 
>> >  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> >
>> >> Hi Russell,
>> >>  
>> >>  On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> >>
>> >>> Add support for legacy non-DT Dove to the PMU driver, so that we can
>> >>> transition the legacy support over.
>> >>>
>> >>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >>
>> >> Applied on mvebu/soc (and fixed a conflict in drivers/soc/Makefile)
>> >
>> > Eventually I applied it on mvebu/drivers rather than mvebu/soc
>> 
>> Actually I was too optimitic. It doesn't build on mvebu/soc (based on
>> 4.4-rc1).
>> 
>> First pm_genpd_poweroff_unused() had been removed since bb4b72fc63d4 "PM
>> / Domains: Remove pm_genpd_poweroff_unused() API ".
>> 
>> Then, even by removing the call this function to go furthetr I got other
>> errors such as: drivers/soc/dove/pmu.c:344:46: error:
>> ?IRQ_DOVE_PMU_START? undeclared (first use in this function)
>
> I guess that's with Arnd's patches?  Sigh, okay, it'll have to wait yet
> _another_ kernel cycle then.

Yes I think the breakage comes from "ARM: orion: use SPARSE_IRQ
everywhere". With this one mach/irqs.h is no more visible by
drivers/soc/dove/pmu.c. But I am sure we can find a solution. It could
not be the first time there is such issue when moving to multiplatform.

Arnd, do you have some suggestion?

Thanks,

Gregory


>
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
