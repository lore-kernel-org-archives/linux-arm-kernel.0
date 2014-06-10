From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 10 Jun 2014 16:35:09 +0200
Subject: ARM: MACH_CPUIMX27 or MACH_EUKREA_CPUIMX27?
Message-ID: <1402410909.3798.32.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Summary: either the Kconfig symbol MACH_CPUIMX27 or the reference to
CONFIG_MACH_EUKREA_CPUIMX27 in arch/arm/tools/mach-types should probably
be renamed (once again).

1) An entry for CONFIG_MACH_CPUIMX27 was added to mach-types in v2.6.29.

2) The Kconfig symbol MACH_EUKREA_CPUIMX27 was added in v2.6.32.

3) That Kconfig symbol was renamed to MACH_CPUIMX27 in v2.6.34, too
match the reference in mach-types mentioned in 1).

4) But then the reference in mach-types was also renamed, to
MACH_EUKREA_CPUIMX27, in v3.1.

5) The net effect is that machine_is_eukrea_cpuimx27() equals 0 since
v3.1. That macro is used only once, in sound/soc/fsl/eukrea-tlv320.c. If
people still care about it then either the Kconfig symbol or the
reference in mach-types should be renamed.


Paul Bolle
