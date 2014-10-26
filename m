From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 26 Oct 2014 12:12:46 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141026110825.GA2263@amd>
References: <20141019090107.GA19132@amd>
 <20141020213518.GB28144@drone.musicnaut.iki.fi> <20141026110825.GA2263@amd>
Message-ID: <201410261212.46582@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 26 October 2014 12:08:25 Pavel Machek wrote:
> Hi!
> 
> > On Sun, Oct 19, 2014 at 09:19:37PM +0200, Pavel Machek wrote:
> > > I am trying to use nfsroot, so I can't use modules.
> > 
> > Why not?
> > 
> > > (I am attaching full config, in case I missed something
> > > important).
> > 
> > I'm using the below config with 3.17 and g_ether works OK.
> > 
> > (My initramfs modprobes g_ether, runs busybox ifconfig for
> > usb0 and launches sshd.)
> 
> I am trying to get 3.14 kernel to work, first. There, usb
> gadget works when compiled into kernel. But with modules, I
> get
> 
> # root@(none):/tmp# insmod libcomposite.ko
> # root@(none):/tmp# insmod u_ether.ko
> # root@(none):/tmp# insmod usb_f_rndis.ko
> # root@(none):/tmp# insmod g_ether.ko
> 
> [  169.061218] udc musb-hdrc.0.auto: registering UDC driver
> [g_ether] [  169.078918] g_ether musb-hdrc.0.auto: failed to
> start g_ether: -2
> 
> -2 is ENOENT...
> 								Pavel

Can you try g_nokia.ko? I used this module for usb networking.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141026/300d43fe/attachment.sig>
