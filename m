From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 10:54:10 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
Message-ID: <201305231054.10735.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> > -config BUG
> > -       bool "BUG() support" if EXPERT
> > -       default y
> > -       help
> > -          Disabling this option eliminates support for BUG and WARN, reducing
> > -          the size of your kernel image and potentially quietly ignoring
> > -          numerous fatal conditions. You should only consider disabling this
> > -          option for embedded systems with no facilities for reporting errors.
> > -          Just say Y.
> 
> ... It's about reducing memory size on devices where you can't show bug or
> warning messages.
> 
> > So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.
> 
> So please keep it.

Agreed. The one annoying property of disabling BUG() support is that it causes
a large number of build warnings since the compiler now has to assume that a lot
of code is reachable when it is normally annotate as unreachable.

When I do "randconfig" tests, I always turn on CONFIG_BUG because of this.

	Arnd
