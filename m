From: robt201108@gmail.com (robert)
Date: Sun, 20 Oct 2013 13:08:34 +0100
Subject: DreamPlug / GuruPlug support in 3.12-rc
Message-ID: <5263C7C2.4000204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have an 'older' DreamPlug, that is - effectively - a GuruPlug inside:

# cat /proc/cpuinfo
processor       : 0
model name      : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 1191.11
Features        : swp half thumb fastmult edsp
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1
Hardware        : Marvell GuruPlug Reference Board
Revision        : 0000
Serial          : 0000000000000000

UBoot:
Marvell-DreamPlug
SoC:   Kirkwood 88F6281_A0

I have managed to get kernels up to 3.11.6 to compile and install OK,
with the 'device tree' option, by selecting 'Marvel GuruPlug reference
board' and 'Marvel GuruPlug reference board (flattened device tree)',
but none of the available options on 3.12-rc seem to work..    I have
tried selecting all the 'Marvell Kirkwood' options, and the 'Marvell
SOC' options, and none of these produces a bootable kernel.

As a test, I temporarily deselected 'Embedded system', and got the
following at boot:
Uncompressing Linux... done, booting the kernel.
Error: unrecognized/unsupported machine ID (r1 = 0x00000a63).
Available machine support:
ID (hex)        NAME
00000b44        Marvell OpenRD Ultimate Board
00000939        Marvell OpenRD Client Board
00000915        Marvell OpenRD Base Board
00000691        Marvell RD-88F6192-NAS Development Board
00000692        Marvell RD-88F6281 Reference Board
ffffffff        Marvell Kirkwood (Flattened Device Tree)
Please check your kernel config and/or bootloader.

0a63(hex) is 2659(dec), which is, in ~/arch/arm/tools/mach-types:
guruplug        MACH_GURUPLUG        GURUPLUG        2659

I appreciate that ARM support in 3.12-rc is still a work-in-progress,
but would like to know if this support will be included soon..   I have
- as usual - tried to find some clues online, but haven't found
anything, so far...

Thanks.

Robert Gadsdon.
