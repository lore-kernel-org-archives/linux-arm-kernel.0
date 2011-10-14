From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 14 Oct 2011 09:12:18 -0700
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <201110141729.41515.arnd@arndb.de>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<20111014071500.GP21648@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A260@HQMAIL01.nvidia.com>
	<201110141729.41515.arnd@arndb.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote at Friday, October 14, 2011 9:30 AM:
...
> You mention that tegra30 will require AUTO_ZRELADDR.

Well, just to be clear, here's the situation I think:

Tegra20's SDRAM starts at physical address 0.

Tegra30's SDRAM starts at physical address 2G.

To support that, we could either:

a) Introduce a new Kconfig variable for Tegra30, make T20/T30 mutually
exclusive, and update arch/arm/mach-tegra/Makefile.boot to set zreladdr
etc. based on the new Tegra30 config variable too. Then, there's no need
for AUTO_ZRELADDR anywhere.

b) Have no new config variable, build a unified T20/T30 kernel, leave
Makefile.boot untouched, and rely on using AUTO_ZRELADDR for Tegra30 to
account for the different SDRAM physical addresses.

> Does that mean that with tegra30 merged you would no longer be able
> to build any tegra kernel?

Sorry, I don't quite understand that question.

-- 
nvpublic
