From: magnus@minimum.se (magnus at minimum.se)
Date: Thu, 12 Mar 2015 17:08:21 +0100
Subject: ARM kernel at memory offset 32MB
Message-ID: <eff7abbdc559c19e63c928c8645205b8.squirrel@lightmail.glesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to run my kernel at an offset of 32 MB in order to reserve the
first 32 MB for an AMP application. I'm using a Xilinx Zynq-7000 where
Linux boots both CPU cores, then brings down CPU #1 and loads a
"baremetal"/AMP application onto it. This app then lives in the first 32
MB of the memory.

I've been able to run the kernel at offset 128 MB, and it correctly
ignores memory below PHYS_OFFSET. If I change it to any offset below 128
MB, the kernel snaps back to running at offset 0x0.

It seems like CONFIG_AUTO_ZRELADDR is what adjusts the load adress here;
and I noticed the alignment is hardcoded to 128 MB. Is this a hardware
limitation (can't we run a kernel at any offset between 0 and 128 MB?)

I tried changing the alignment in arch/arm/boot/compression/head.S and it
seems to work, but I feel like I'm on really thin ice here. I also tried
disabling CONFIG_AUTO_ZRELADDR, but it seems like my arch depend on it..?

Is it completely insane to try to reserve memory in front of the kernel?
Should I just go ahead and reserve memory after the kernel instead?

best regards, Magnus
