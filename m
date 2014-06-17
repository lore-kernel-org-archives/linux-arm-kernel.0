From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jun 2014 13:05:11 +0200
Subject: [PATCH v2 00/08] ARM: shmobile: Rework include path V2
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <201406171305.12186.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 June 2014, Magnus Damm wrote:
> Please note that these are only lightly compile tested with a handful
> of defconfigs, but any potential issue should be trivial to fix.
> 
> Also, there are certain bits of arch/arm/mach-shmobile/include/mach/
> get included from places like arch/arm/boot/compressed/ (booting
> legacy kernel directly from reset vector) and also from SoC specific
> legacy code under drivers/pinctrl. My proposal is to keep those users
> as-is until we phase out legacy board support (2-3 kernels?), let me
> know if you would like to get rid of "include/mach" sooner!

If it's only about arch/arm/boot/compressed, you can just move the
header files to the same directory, as nothing else includes them.

I've played with a full multiplatform conversion of a few platforms
including shmobile in the past, and all I needed for the legacy pinctrl
drivers was to duplicate the irq_pin() definition, which is probably
a reasonable hack for code that we know is going away anyway, just
add a comment for both definitions explaining that they have to be
kept in sync. This one is less obvious than the boot header.

One general comment: please use 'git format-patch -M' or set the
'diff.renames' git option for sending patches for reviews that
rename files. No need to send this patch set again.

	Arnd
