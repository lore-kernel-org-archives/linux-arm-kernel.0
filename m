From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Apr 2015 14:22:35 +0200
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <CAK7LNATkYVwT337okeW=c1NjyxB4ovXKSNzxtTwk7XXGN45z7w@mail.gmail.com>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
 <3196164.8b31S2QWFd@wuerfel>
 <CAK7LNATkYVwT337okeW=c1NjyxB4ovXKSNzxtTwk7XXGN45z7w@mail.gmail.com>
Message-ID: <19177883.oJbWsfhyVG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 April 2015 17:22:32 Masahiro Yamada wrote:
> Hi Arnd,
> 
> Thanks for your comment!
> 
> 2015-04-07 16:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday 07 April 2015 12:34:30 Masahiro Yamada wrote:
> >>
> >> What is the cause of the kernel panic?  How to fix it?
> >> Any hint is very appreciated.
> >>
> >
> > Cortex-A9 usually need to set up the L2 Cache controller, and you
> > don't have a node for that.
> >
> > Can you try adding a DT node for it? You may also have to specify
> > the overrides for its aux control register in DT if that is not
> > set up right by the boot loader or the power-on defaults.
> 
> I have not checked the L2 (outer) cache yet.
> 
> The L2 cache on our SoC is not a famous IP, but our own implementation.
> I will have to implement L2 code as well as the device tree node.
> Is there any workaround to boot Linux without L2 cache?

It should work normally, I think the only dangerous combination is
when the L2 controller is enabled but not configured correctly.

It's also quite likely that there is some other problem with your
user space image. Are you able to boot the same image inside of
qemu or on another hardware that is supported with multi_v7_defconfig?

	Arnd
