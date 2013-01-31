From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Jan 2013 07:44:26 -0500
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <510A5D38.9040608@free-electrons.com>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
 <510959D5.1010305@free-electrons.com>
 <20130130181035.GP7717@titan.lakedaemon.net>
 <20130131095025.GC20242@lunn.ch> <20130131110716.50b7340b@skate>
 <510A5D38.9040608@free-electrons.com>
Message-ID: <20130131124426.GA7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 01:02:00PM +0100, Gregory CLEMENT wrote:
> On 01/31/2013 11:07 AM, Thomas Petazzoni wrote:
> > Dear Andrew Lunn,
> > 
> > On Thu, 31 Jan 2013 10:50:25 +0100, Andrew Lunn wrote:
> > 
> >> We have the same issue with OpenBox AX3. All the devices we have in
> >> our hands have 1GB soldered down, plus 2GB on expansion. The DT
> >> currently has the full 3GB.
> >>
> >> However, there has been discussion of reducing this down to 1GB since
> >> both Thomas and Gregory have unstable systems with the full 3GB, but
> >> mine box is stable with the full 3GB. So i don't know how strong a
> >> precedent that sets....
> > 
> > It seems that if we have CONFIG_ARM_ATAG_DTB_COMPAT, then the code in
> > arch/arm/boot/compressed/atags_to_fdt.c will update the DT memory node
> > according to the ATAG_MEM passed by the bootloader.
> > 
> 
> From my point of view these dts file are just given as reference, and the
> bootloader should be able to modify them on the fly according the hardware
> configuration of the board.
> 
> And for old bootloader then we can use the CONFIG_ARM_ATAG_DTB_COMPAT as
> pointed by Thomas.
> 
> So I am not sure that the amount of memory is very important.
> 
> However I think that having a value by default is useful, so unless
> there is a strong argument against it, I would like to keep it, maybe with
> a comment in the dts to emphasize that it is just a default value and the
> amount of memory can be changed.

Let's go with the comment.  Upgradeable memory is still fairly uncommon
in embedded, it won't hurt to let folks know the bootloader will set it
(hopefully) correctly.

thx,

Jason.
