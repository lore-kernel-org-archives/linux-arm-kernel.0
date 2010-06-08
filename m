From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 21:00:11 +0800
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100608124913.GC25370@n2100.arm.linux.org.uk>
References: <201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<20100608123102.GT15515@atomide.com>
	<AANLkTilyaRYigz2LoirclkNHyj3g3CUogM6OmnpUfM4M@mail.gmail.com>
	<20100608124913.GC25370@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilnzP--UT_Jwr8PfODhp4GVjhfDvBETLsRv-slG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 8:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 08, 2010 at 08:43:13PM +0800, Eric Miao wrote:
>> Just wondering if a migration path is possible. Does anyone seriously think
>> about the solution Linus proposed and maybe we can have an implementation
>> and have all defconfig going that way before they are completely purged?
>
> Doesn't select from an 'm' symbol cause the target of the select to end
> up being 'm' ? ?If yes, we have a way to solve this today.
>

Have a quick test and it seems to be the case.

> config ARM_PLATFORM_FOO
> ? ? ? ?bool "Default configuration for FOO"
> ? ? ? ?select ARCH_FOO
> ? ? ? ?select VIDEO_WHATEVER
>
> config ARM_PLATFORM_FOO_MOD
> ? ? ? ?tristate
> ? ? ? ?default m if ARM_PLATFORM_FOO
> ? ? ? ?select I2C
> ? ? ? ?select SPI
>
> etc. ?We just need to be very careful about dependencies for things like
> I2C, SPI, etc.
>
