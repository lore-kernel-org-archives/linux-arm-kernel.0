From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Mar 2015 01:32:21 -0700
Subject: [PATCHv2 0/3] amba: tegra-ahb: fix base address and register offsets
 for future chip support
Message-ID: <20150317083221.32662.14647.stgit@baseline>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(This second transmission fixes a few errors in the original mails:
notably, the E-mail address of the linux-arm-kernel mailing list was
incorrect, and the patches are based on next-20150316 rather than
next-20150311.  The code itself is unchanged.)

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

(The multi_v7_defconfig test failure is unrelated to this series.)

This series is based on next-20150316 and is intended for v4.1.


- Paul
