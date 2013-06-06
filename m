From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 18:19:58 +0200
Subject: [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
In-Reply-To: <CANqRtoQZWmyMS6w2n9uW1-92-DOZcBst7gpCMrAC7GE9EwZUuQ@mail.gmail.com>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <201306051351.14978.arnd@arndb.de>
 <CANqRtoQZWmyMS6w2n9uW1-92-DOZcBst7gpCMrAC7GE9EwZUuQ@mail.gmail.com>
Message-ID: <201306061819.58616.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Magnus Damm wrote:
> There are basically 4 types of zImages for mach-shmobile:
> 
> 1) Regular zImage/uImage - DTB and ATAGS are passed from boot loader -
> head-shmobile.S is not used.
> 
> 2) Boot directly from MASK ROM from MMCIF/SDHI - head-shmobile.S loads
> via MMC, sets up memory via mach/zboot.h, set ATAGS to NULL and passes
> MACH_TYPE to kernel, ->fixup() sets up the actual memory bank
> information.
> 
> 3) Boot directly from NOR Flash - head-shmobile.S includes memory
> setup code from mach/zboot.h, passes MACH_TYPE to kernel running in
> flash.
> 
> 4) Boot directly from MASK ROM via USB gadget - (r_usb_boot [1] runs
> on your PC and loads to internal SRAM) - starts same image as 3)
> above.
> 
> To answer your question about multiplatform images, I believe  the
> majority case 1) above will run just fine.

Ok, got it, thanks for the explanation!

> Regarding 2) -> 4), those are currently very specific to a certain
> platform and they start directly from the reset vector which would
> require them to either keep the board info hard-coded in the image or
> somehow auto-detect board. From a hardware point of view I don' t
> think there is any simple way to auto detect the boards in
> mach-shmobile I'm afraid, so it looks to me that 2) -> 4) need to stay
> board-specific.

Yes, that makes sense.

Just for completeness, am I guessing right that cases 2-4 are only for
the previous "Renesas Technology" chips and their suggessors, while
the previous NEC Emma EV2 only does the regular zImage boot?
What about the current "Renesas Electronics" parts that include NEC
technology, do they all support the head-shmobile.S direct boot?

	Arnd
