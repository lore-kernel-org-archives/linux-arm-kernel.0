From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 23 May 2010 12:09:25 +0200
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <20100523090139.GA950@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun\, 23 May 2010 10\:01\:39 +0100")
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr> <20100522094637.GA954@n2100.arm.linux.org.uk>
	<87pr0n31q2.fsf@free.fr> <20100523090139.GA950@n2100.arm.linux.org.uk>
Message-ID: <87hblz2alm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sun, May 23, 2010 at 02:23:33AM +0200, Robert Jarzmik wrote:
> The reason that initrd_start is zero at rd_load_ramdisk is that in
> populate_rootfs(), the initrd is written into the ramfs root as a
> /initrd.image file.  Then the original initrd image is freed, resulting
> in both initrd_start and initrd_end being zeroed.
I understand better now.

> Do you have CONFIG_BLK_DEV_RAM enabled?  Try some debugging (using
> pr_err() and booting with 'quiet' so you can see the output) in
> populate_rootfs().
CONFIG_BLK_DEV_RAM is enabled. I'll add some debugging now and will try again.

Thanks for the help.

--
Robert
