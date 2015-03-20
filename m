From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Mar 2015 00:11:02 -0600
Subject: amba: tegra-ahb: fix base address and register offsets for future
 chip support
Message-ID: <20150320061102.14355.4781.stgit@mcwayne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From a hardware SoC integration point of view, the offsets of the
Tegra AHB registers that are currently defined in tegra-ahb.c macros
are all off by four bytes.  Similarly, the starting address of this IP
block in our existing DT files is also off by four bytes.  This series
fixes the driver such that the macro offsets are correct, and that the
driver is backwards-compatible with previous chip DT data, but that future
chip DT data can use the correct base.  See also

    http://www.spinics.net/lists/arm-kernel/msg394171.html

This series has been boot-tested on Tegra20 Trimslice, Tegra30
Beaver, Tegra114 Dalmore, Tegra124 Jetson TK1, Tegra132 Norrin64
FFD (with a few additional out-of-tree patches, since T132
support is not yet upstream), and QEMU Versatile Express 64.
Basic build and boot test logs for T30, T114, T124, and QEMU
Versatile Express 64 are here:

http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150317011136_159e7763d517804c61a673736660a5a35f2ea5f8/20150317011136/

This series is based on next-20150319 and is intended for v4.1.

This third version of the series incorporates feedback from Russell
King <linux@arm.linux.org.uk> and Stephen Warren <swarren@wwwdotorg.org>.


- Paul
