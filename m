From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Mar 2014 12:36:53 -0500
Subject: [RFC] possible removal of omap-serial
In-Reply-To: <20140321171029.GC3842@atomide.com>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
 <20140321023646.GB17404@kroah.com>
 <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
 <20140321025238.GA31610@saruman.home>
 <20140321171029.GC3842@atomide.com>
Message-ID: <20140321173653.GP12310@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 21, 2014 at 10:10:30AM -0700, Tony Lindgren wrote:
> > > On the support side, I'm not looking forward to this for beagle/panda
> > > users.  We've already converted them once from ttySx -> ttyOx back in
> > > 2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...
> > 
> > that's exactly why we're talking about ways to maintain backwards
> > compatibility here. But I'm more interested in finding a way to switch
> > over to ttyS and have a symlink to ttyO, that way a simple debootstrap
> > (or any other ARM distro minimal rootfs) would work out of the box,
> > without any changes, just like in "normal" systems.
> 
> Yeah let's not break things. The symlink solution won't work for kernel

again. Let's not break things again.

> console output so it needs to be dealt with some other way.

it would if kernel itself would create the symlink, but that might not
be doable in a clean way.

> It seems that the biggest amount of work is making existing 8250
> support the missing features in a clean way and without breaking
> other platforms. Looks like 8250_dw.c has some pm_runtime_calls so
> obviously it's doable.

right

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/2335bfe4/attachment.sig>
