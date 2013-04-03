From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 3 Apr 2013 12:46:08 +0200
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <20130329193716.GA7127@localhost>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
Message-ID: <20130403124608.5de971f1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Fri, 29 Mar 2013 16:37:17 -0300, Ezequiel Garcia wrote:

> As far as I can remember, Gregory has a Mirabox with only 512 MiB,
> which means some boards were shipped with 512 MiB and some with 1 GiB.
> Moreover, apparently nothing can distinguish one from the other.

I do confirm that some Mirabox only have 512 MB of RAM, at least
according to U-Boot:

U-Boot 2009.08 (May 23 2012 - 16:35:03)Marvell version: 1.1.0 NQ
U-Boot Addressing:
       Code:		00600000:006AFFF0
       BSS:		006F8E40
       Stack:		0x5fff70
       PageTable:	0x8e0000
       Heap address:	0x900000:0xe00000
Board: DB-88F6710-BP
SoC:   MV6710 Z1
CPU:   Marvell PJ4B v7 UP (Rev 1) LE
       DDR @ 600Mhz, TClock @ 200Mhz
       DDR 16Bit Width, FastPath Memory Access
PEX 0: Root Complex Interface, Detected Link X1
PEX 1: Root Complex Interface, Detected Link X1
DRAM:  512 MB
       CS 0: base 0x00000000 size 512 MB
       Addresses 14M - 0M are saved for the U-Boot usage.

The mvebu_defconfig contains CONFIG_ARM_ATAG_DTB_COMPAT=y, so it should
automatically pick up the amount of memory defined by U-Boot in the
ATAGS.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
