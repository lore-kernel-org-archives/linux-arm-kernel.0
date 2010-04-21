From: therealbadguy@gmail.com (Badguy Badguy)
Date: Wed, 21 Apr 2010 16:35:12 -0600
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <20100420081323.GD30807@buzzloop.caiaq.de>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
	<20100415075831.GL30801@buzzloop.caiaq.de>
	<i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
	<20100416083632.GF30801@buzzloop.caiaq.de>
	<z2z3f34cd261004191240nce56a951jb24c4ce3c0c47503@mail.gmail.com>
	<20100420081323.GD30807@buzzloop.caiaq.de>
Message-ID: <q2h3f34cd261004211535vb6ebbaa0k551449e9a1a10285@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your input.

I got the NFS to mount, was missing an option in the config.

but now I get a panic - not syncing: Attempted to kill init!

I verified I am passing the string via bootloader:
init=/sbin/init
 this is a symlink to my busybox.

I think perhaps this is a complier problem, not 100% sure tho.
I believe I have recompiled the busybox via ltib and that should have solved it.

can you tell me what toolchain you are using to compile this kernel?
where you obtained it? did you compile it yourself?

I am using one from an older ltib, as the current one they are using
throws the error that it miscompiles the __weak directive.
I am using:
 gcc-4.1.2

 gcc-4.1.1 is the one that throws the error.

>> Can I get a break down on how far you have run this kernel? Do you
>> have file system support?
>
> I can fully boot the board via NFS and have a working system with
> Ethernet, MMC/SDIO, LED, GPIO, SPI and USB support.
>

I notice that these drivers are loading correctly, and look good as
far as the initialization goes.

>> I notice the NAND driver is throwing bad erase block warnings on a
>> large number of blocks, I will change SOM and see if it continues.
>
> I'll again check for NAND and NOR later today, but I'm sure the chips
> are at least probed correctly.
>

 I did an erase on the memory, and this has stopped the bad block
warnings, good enough for now.


Thanks!

  Chris
