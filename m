From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 26 Oct 2014 23:23:17 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141026215548.GA9004@amd>
References: <20141019090107.GA19132@amd> <201410262222.39892@pali>
 <20141026215548.GA9004@amd>
Message-ID: <201410262323.17891@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 26 October 2014 22:55:48 Pavel Machek wrote:
> > > I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> > > rx51_defconfig, but no, it refuses to mount it.
> > > 
> > > VFS: Cannot open root device "mmcblk0p6" or ....: error
> > > -19.
> > > 
> > > And then it proceeds to list mmcblk0p6 as one of available
> > > options
> > > 
> > > :-(.
> > > 
> > > Ideas welcome.
> > 
> > Try to add rootdelay=30 or rootwait to kernel cmdline.
> 
> I had rootdelay=3. Will try rootwait... no change. This is
> v3.17 with rx51_defconfig. CONFIG_MACH_NOKIA_RX51=y => device
> tree will not be used AFAICT.
> 
> Now I'm back at 3.14 without device tree; same setup works
> there. I tried disabling RX51 support in 3.14 (to make it
> boot using device tree) but that did not work.
> 								Pavel

I remember that there was some problem with initializing mmc 
device. Sometimes something failed and reading from eMMC was not 
possible. Try to boot kernel from uboot. Maybe it can help.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141026/10e23158/attachment.sig>
