From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jul 2015 14:23:19 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <CACRpkdb3k+s65tOR13iKNLqJ+CWvxSH6d3Z2Ra4OJ9rw+t2Q3w@mail.gmail.com>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
 <2694937.qjRpGCMvqj@wuerfel>
 <CACRpkdb3k+s65tOR13iKNLqJ+CWvxSH6d3Z2Ra4OJ9rw+t2Q3w@mail.gmail.com>
Message-ID: <3466799.BCvMeL6TVk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 July 2015 21:57:35 Linus Walleij wrote:
> On Thu, Jul 16, 2015 at 4:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 16 July 2015 16:03:18 Linus Walleij wrote:
> 
> >> The aliases are set also to disabled ports to ensure enumeration
> >> for the cases where a board file enabled a previously disabled
> >> UART.
> >>
> >
> > Well, both really. The status property tells the kernel to not
> > ever touch a device, while the alias is what traditionally gets
> > used to assign an OS visible device name to a device in the tree.
> > This is more true for MacOS and AIX than Linux, which sometimes
> > does its own naming, but we really should not have an alias pointing
> > at a disabled device node.
> 
> OK ... I will make a patch that remove the aliases for the disabled
> nodes.
> 
> But this makes me think of whether the DT compiler should allow
> it or at least warn about it?

We don't get a lot of warnings from dtc at the moment, but
we could start adding them for stuff like this. It probably
requires looking at the whole dtb a bit deeper than dtc
does at the moment.

	Arnd
