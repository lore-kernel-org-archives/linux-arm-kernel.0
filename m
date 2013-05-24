From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 09:43:13 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305240915.27847.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
 <201305240915.27847.arnd@arndb.de>
Message-ID: <20130524094313.669ab838@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 24 May 2013 09:15:27 +0200, Arnd Bergmann wrote:

> But there is no problem on those boards /yet/. So far, the two boards
> always come with the known 0xd0 configuration that match the DTs
> we have, independent of where they come from.
> 
> Thomas wants to be prepared for them to do something stupid, and he
> anticipates that they are going to do it in a particular way, but
> he says that he has no control over them, so it's all speculation
> at this point,

Speculation? The new bootloaders that change the address to 0xf1000000
are already shipping on all new Marvell evaluation platforms, they are
the ones currently available to Marvell customers for their
developments, and I'm running such a new bootloader on an evaluation
board.

I wouldn't call speculation something that I have in front of my eyes
today. But maybe we don't have the same definition of speculation.

> unless we do something stupid and change the dts
> files in the kernel to no longer match the current hardware.

You are again making the same mistake again. You make the association
between a given hardware platform and the location of the internal
registers, but this is completely false. Current OpenBlocks are shipped
with a old bootloader, but new OpenBlocks will most likely be shipped
with a new bootloader, or existing users of OpenBlocks may upgrade
their bootloader. So you can't make the assumption that OpenBlocks ==
old register address.

Again, we do *NOT* want to make this address configurable. All boards
should use 0xf1000000, and the kernel should assume that this a fixed
location for the internal registers.

All what we're trying to achieve here is to provide some temporary
workaround to help people using old bootloaders move smoothly to newer
bootloaders version without having a completely silent kernel at boot
time in the mean time.

So, while we are seeking for a workaround for a mistake of the past,
you are trying to force us to generalize the mechanism of customizing
the internal register address, which we do not want to do.

If all you're willing to accept is a very complex generalization of the
internal register base address handling, then I believe what we're
going to do is just move all Device Tree sources to use 0xf1, and we'll
tell users to upgrade their bootloader.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
