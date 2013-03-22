From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 13:34:07 +0000
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <CACRpkdbaRyHxeJM=JT+9CtVf-_u90wCzjePDvsNq-EQd_NxLdg@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <CACRpkdbaRyHxeJM=JT+9CtVf-_u90wCzjePDvsNq-EQd_NxLdg@mail.gmail.com>
Message-ID: <201303221334.07330.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Linus Walleij wrote:
> On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > This is
> > what I came up with, on top of your patches. Feel free to take what
> > you need if you don't already have the same patches.
> >
> > I've successfully built "allmodconfig" with all the other v6/v7
> > platforms enabled as well.
> 
> Unfortunately the platform stops booting after
> 2/9 "ARM: ux500: split out prcmu initialization"
> so I will look closer at this.

Yes, I can see how it has potential for introducing bugs. I hope it's
something obvious that you can find easily.

> This patch:
> "ARM: ux500: kill mach/hardware.h some more"
> I will squash into the actual removal patch, it's just
> some sloppy work by me :-/

Yes, I expected that.

> I will try to move some of the patches to the
> front of the series so we only have the tricky stuff to
> fix.

Ok.

> And there are some non-bisectable patches due to the
> driver in staging (which was put there because Synaptics would
> submit another driver "real soon now" and that was something like
> two years ago), so I might have to squash some of them together to one.

What breaks bisection here? The "[PATCH 5/9] staging: ste_rmi4: kill
platform_data hack" patch should be independent of everything else,
it just touches more files than we'd like.

	Arnd
