From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jan 2014 14:58:41 +0000
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <20140110142548.GG9681@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net> <20140109165557.GB9681@lunn.ch>
 <52CF4652.3030207@killerwolves.net>
 <20140110112846.GG27432@n2100.arm.linux.org.uk>
 <52CFFF07.5080806@killerwolves.net> <20140110142548.GG9681@lunn.ch>
Message-ID: <20140110145841.GF15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 03:25:48PM +0100, Andrew Lunn wrote:
> On Sat, Jan 11, 2014 at 12:09:11AM +1000, Ben Peddell wrote:
> > Bytes transferred = 1954736 (1dd3b0 hex)
> > Marvell>> setenv bootargs console=ttyS0,115200 ip=off initrd=0x00800040,0x0013FFC0 root=/dev/md0 rw syno_hw_version=DS211j ihd_num=2 netif_num=1 earlyprintk
> 
> I don't see you loading the initrd into RAM at 0x0080 0000.

However, the kernel _is_ being told that the initrd is at 0x00800040.

> > Uncompressing Linux... done, booting the kernel.
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 3.13.0-rc7-ds211j+ (root at lurch) (gcc version 4.8.2 (Gentoo 4.8.2 p1.3, pie-0.5.8) ) #2 Thu Jan 9 08:52:24 EST 2014
> > [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
> > [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> > [    0.000000] Machine model: Synology DS210 v10, v20, v30, DS211j
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] INITRD: 0xf8280040+0x000f993c is not a memory region - disabling initrd
> 
> The kernel is correct. There is no RAM here. That is in the IOMEM
> space.

But here the kernel has ignored the command line parameter and instead
used the one passed via DT.  That is not correct - command line parameters
must always override ATAGs or DT.

(That's irrespective of whether what's actually being asked of the kernel
is correct or not - the principle here applies that command line parameters
override, and in this case they aren't.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
