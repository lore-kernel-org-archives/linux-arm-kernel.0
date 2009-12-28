From: stevenm86@gmail.com (Steve Moskovchenko)
Date: Mon, 28 Dec 2009 17:26:59 -0500
Subject: Footbridge / 21285 phsical/virtual address selection patch
Message-ID: <1262039219.28196.124.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
        
I've got my hands on a weird-ish ARM board with an SA-110 and a 21285
footbridge. It is NOT the EBSA285 (it actually used to be a Quantum
netdisk NAS) but it is close and I have the kernel configured in
"EBSA285 Host" mode because it is close enough. (I had to comment out a
beq instruction in the platform checker to get the kernel to boot on
this board).
        
Well...
        
I've run into some issues. The MMU code seems broken somewhere, and the
kernel only works for me in NOMMU mode. However, in the (MM)I/O address
mapping for the 21285 driver, the footbridge code completely ignores
CONFIG_MMU and has all the I/O addresses #defined as if they were all
virtual. This is obviously not going to work if the MMU is disabled and
all the addresses will be wrong.
        
I've attached a patch (-p0) that adds an #ifdef to select between
physical and virtual addresses for the 21285 chip, depending on
CONFIG_MMU. I do not have a real EBSA285 to test this on, but this board
does have a real 21285 and it is working for me. 
        
I've run into some additional problems, specifically with the uart
driver, but I will prepare some of those patches in a bit.
        
What do you guys think?
        
Thanks
Steve
-------------- next part --------------
A non-text attachment was scrubbed...
Name: footbridge-nommu.patch
Type: text/x-patch
Size: 1793 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091228/4d5417d8/attachment.bin>
