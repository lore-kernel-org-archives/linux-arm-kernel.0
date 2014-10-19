From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 19 Oct 2014 23:00:20 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141019205033.GA4738@amd>
References: <20141019090107.GA19132@amd> <201410191658.45851@pali>
 <20141019205033.GA4738@amd>
Message-ID: <201410192300.20625@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 October 2014 22:50:36 Pavel Machek wrote:
> On Sun 2014-10-19 16:58:45, Pali Roh?r wrote:
> > On Sunday 19 October 2014 12:07:39 Pavel Machek wrote:
> > > On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > From 3.6 to 3.10, USB networking works on Nokia N900.
> > > > With 3.11, it fails with messages on the host. I also
> > > > tried to get it to work on 3.14 and 3.17, with no luck.
> > > > 
> > > > Any ideas? Does it work for you? Any config options to
> > > > watch for?
> > > 
> > > With 3.17, I get
> > > 
> > > omap_musb_mailbox: musb core is not yet ready
> > > 
> > > message. It looks related...?
> > 
> > Can you try tree
> > https://gitorious.org/linux-n900/linux-n900/ ?
> > 
> > I think with rx51_defconfig from above tree it worked fine
> > for 3.10 - 3.13 versions.
> 
> From your tree, I am trying
> 815039686baffff6432b45028dd405b1981a9112 (3.16 based). I
> attempted to make gadget drivers build-in and enabled
> nfsroot. I could not detect nokia on USB after bootup.
> 
> Are you sure about defconfig? AFAICT defconfig will always be
> unsuitable for nfsroot, as it will not contain nfs support
> built-in...
> 
> I am trying c089e5f8ba2d44afd2db2c2042d43ca70205c536 (3.13
> based). Same result :-(.
> 
> Do you have any tree where usb gadget works for you?
> 
> Thanks,
> 									Pavel

My N900 can boot kernel from v3.12-rc5-n900 branch compiled with 
arch/arm/configs/rx51_defconfig. Also it can boot full Maemo5 
system (with CSSU and some minor system changes) and usb network 
via g_nokia.ko gadget working fine...

So if it does not working for you then kernel usb subsystem could 
have problems with using gadgets directly from zimage.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141019/9f7113ee/attachment.sig>
