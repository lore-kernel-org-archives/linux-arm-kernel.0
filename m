From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Jan 2013 11:07:16 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <20130131095025.GC20242@lunn.ch>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
 <510959D5.1010305@free-electrons.com>
 <20130130181035.GP7717@titan.lakedaemon.net>
 <20130131095025.GC20242@lunn.ch>
Message-ID: <20130131110716.50b7340b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 31 Jan 2013 10:50:25 +0100, Andrew Lunn wrote:

> We have the same issue with OpenBox AX3. All the devices we have in
> our hands have 1GB soldered down, plus 2GB on expansion. The DT
> currently has the full 3GB.
> 
> However, there has been discussion of reducing this down to 1GB since
> both Thomas and Gregory have unstable systems with the full 3GB, but
> mine box is stable with the full 3GB. So i don't know how strong a
> precedent that sets....

It seems that if we have CONFIG_ARM_ATAG_DTB_COMPAT, then the code in
arch/arm/boot/compressed/atags_to_fdt.c will update the DT memory node
according to the ATAG_MEM passed by the bootloader.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
