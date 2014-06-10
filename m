From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jun 2014 16:01:00 +0100
Subject: ARM: MACH_CPUIMX27 or MACH_EUKREA_CPUIMX27?
In-Reply-To: <1402410909.3798.32.camel@x220>
References: <1402410909.3798.32.camel@x220>
Message-ID: <20140610150100.GY23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 04:35:09PM +0200, Paul Bolle wrote:
> 0) Summary: either the Kconfig symbol MACH_CPUIMX27 or the reference to
> CONFIG_MACH_EUKREA_CPUIMX27 in arch/arm/tools/mach-types should probably
> be renamed (once again).
> 
> 1) An entry for CONFIG_MACH_CPUIMX27 was added to mach-types in v2.6.29.
> 
> 2) The Kconfig symbol MACH_EUKREA_CPUIMX27 was added in v2.6.32.
> 
> 3) That Kconfig symbol was renamed to MACH_CPUIMX27 in v2.6.34, too
> match the reference in mach-types mentioned in 1).
> 
> 4) But then the reference in mach-types was also renamed, to
> MACH_EUKREA_CPUIMX27, in v3.1.
> 
> 5) The net effect is that machine_is_eukrea_cpuimx27() equals 0 since
> v3.1. That macro is used only once, in sound/soc/fsl/eukrea-tlv320.c. If
> people still care about it then either the Kconfig symbol or the
> reference in mach-types should be renamed.

This is caused by the way mach-types is dealt with, and I've told people
/many/ times exactly how it's done - but still they don't get it.

The information is stored in a database, where the database is accessible
via the web.

Every so often, I download from that website a new copy of the mach-types
file and commit the update.  Due to the shere number of changes, it is
impossible to go through one by one working out whether it's changed in
the kernel or whether it's a change which has happened via the website.

Once a platform has been merged into mainline, the symbols are not allowed
to be changed from that point on, because to do so breaks the ability for
people to update this file in older/newer kernels.

So, if mach-types says that it is MACH_EUKREA_CPUIMX27, then that is what
the symbol is supposed to be (and to try and change it will cause problems.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
