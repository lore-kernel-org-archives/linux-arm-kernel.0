From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Oct 2014 22:50:36 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <201410191658.45851@pali>
References: <20141019090107.GA19132@amd> <20141019100739.GA2547@amd>
 <201410191658.45851@pali>
Message-ID: <20141019205033.GA4738@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-10-19 16:58:45, Pali Roh?r wrote:
> On Sunday 19 October 2014 12:07:39 Pavel Machek wrote:
> > On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > > Hi!
> > > 
> > > From 3.6 to 3.10, USB networking works on Nokia N900. With
> > > 3.11, it fails with messages on the host. I also tried to
> > > get it to work on 3.14 and 3.17, with no luck.
> > > 
> > > Any ideas? Does it work for you? Any config options to watch
> > > for?
> > 
> > With 3.17, I get
> > 
> > omap_musb_mailbox: musb core is not yet ready
> > 
> > message. It looks related...?
> 
> Can you try tree https://gitorious.org/linux-n900/linux-n900/ ?
> 
> I think with rx51_defconfig from above tree it worked fine for 
> 3.10 - 3.13 versions.

>From your tree, I am trying 815039686baffff6432b45028dd405b1981a9112
(3.16 based). I attempted to make gadget drivers build-in and enabled
nfsroot. I could not detect nokia on USB after bootup.

Are you sure about defconfig? AFAICT defconfig will always be
unsuitable for nfsroot, as it will not contain nfs support built-in...

I am trying c089e5f8ba2d44afd2db2c2042d43ca70205c536 (3.13
based). Same result :-(.

Do you have any tree where usb gadget works for you?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
