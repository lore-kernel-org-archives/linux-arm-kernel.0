From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Jun 2016 17:08:32 -0400
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
Message-ID: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many users (and some applications) are expecting the CPU clock speed to
be output in /proc/cpuinfo (as is done in x86, avr32, c6x, tile, parisc,
ia64, and xtensa).  This can be trivially added by simply querying the
clock described in the CPU node of the device tree.  It appears that
many of the DTSI files in arch/arm/boot/dts already have this defined.
So, this will add this desired functionality for many boards with
already existing information.  For those that do not have this defined,
it will simply not output the string in question (thus keeping
everything the same as before).

The output was modeled after x86 (based on number of significant digits
and location in the output), but is similar to other architectures.  For
example, the output on my local board looks like:

# cat /proc/cpuinfo 
processor	: 0
model name	: ARMv7 Processor rev 0 (v7l)
cpu MHz		: 1200.000
BogoMIPS	: 1200.00
Features	: half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x3
CPU part	: 0xc09
CPU revision	: 0

processor	: 1
model name	: ARMv7 Processor rev 0 (v7l)
cpu MHz		: 1200.000
BogoMIPS	: 1200.00
Features	: half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x3
CPU part	: 0xc09
CPU revision	: 0

Hardware	: Broadcom Northstar Plus SoC
Revision	: 0000
Serial		: 0000000000000000

Thanks,
Jon



Jon Mason (1):
  ARM: print MHz in /proc/cpuinfo

 arch/arm/kernel/setup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
1.9.1
