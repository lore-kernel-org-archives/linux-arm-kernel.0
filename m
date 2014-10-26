From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 26 Oct 2014 22:22:39 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141026211721.GA7351@amd>
References: <20141019090107.GA19132@amd> <201410261212.46582@pali>
 <20141026211721.GA7351@amd>
Message-ID: <201410262222.39892@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 26 October 2014 22:17:21 Pavel Machek wrote:
> On Sun 2014-10-26 12:12:46, Pali Roh?r wrote:
> > On Sunday 26 October 2014 12:08:25 Pavel Machek wrote:
> > > Hi!
> > > 
> > > > On Sun, Oct 19, 2014 at 09:19:37PM +0200, Pavel Machek 
wrote:
> > > > > I am trying to use nfsroot, so I can't use modules.
> > > > 
> > > > Why not?
> > > > 
> > > > > (I am attaching full config, in case I missed
> > > > > something important).
> > > > 
> > > > I'm using the below config with 3.17 and g_ether works
> > > > OK.
> > > > 
> > > > (My initramfs modprobes g_ether, runs busybox ifconfig
> > > > for usb0 and launches sshd.)
> > > 
> > > I am trying to get 3.14 kernel to work, first. There, usb
> > > gadget works when compiled into kernel. But with modules,
> > > I get
> > > 
> > > # root@(none):/tmp# insmod libcomposite.ko
> > > # root@(none):/tmp# insmod u_ether.ko
> > > # root@(none):/tmp# insmod usb_f_rndis.ko
> > > # root@(none):/tmp# insmod g_ether.ko
> > > 
> > > [  169.061218] udc musb-hdrc.0.auto: registering UDC
> > > driver [g_ether] [  169.078918] g_ether musb-hdrc.0.auto:
> > > failed to start g_ether: -2
> > > 
> > > -2 is ENOENT...
> > 
> > Can you try g_nokia.ko? I used this module for usb
> > networking.
> 
> I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> rx51_defconfig, but no, it refuses to mount it.
> 
> VFS: Cannot open root device "mmcblk0p6" or ....: error -19.
> 
> And then it proceeds to list mmcblk0p6 as one of available
> options
> 
> :-(.
> 
> Ideas welcome.
> 									Pavel

Try to add rootdelay=30 or rootwait to kernel cmdline.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141026/1b926083/attachment-0001.sig>
