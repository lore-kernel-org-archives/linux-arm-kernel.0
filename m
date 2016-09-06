From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 6 Sep 2016 13:03:42 -0700
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <20160906194443.GC1041@n2100.armlinux.org.uk>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <20160906142442.GY1041@n2100.armlinux.org.uk>
 <6239709.hYdxF7WW9G@wuerfel> <20160906194443.GC1041@n2100.armlinux.org.uk>
Message-ID: <CA+55aFyrGTG3xzecScrTQKaqkZ96DizeH2aSjJENKB_DCD6hxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 12:44 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> My point still stands though.  Merely hiding it doesn't make the problem
> go away - it's just the same problem but now it won't be as visible, and
> as such it'll probably never get resolved.

How much of a legacy thing is this?

The main reason I'd like to _really_ make NO_IRQ go away is that it
seems that some people copy it from existing drivers, or just think
it's the RightThing(tm) to do because it looks so plausible.

So in that sense I wouldn't actually mind "merely hiding it".

It may not *fix* that particular driver or subsystem, but if it's
sufficiently well hidden or specialized, at least it won't cause the
pattern to be copied in the future, I'd hope.

So hiding things inside a particular driver (or a particular
subsystem) may be hacky from the standpoint of that particular driver
or subsystem, but from a "big issue" standpoint I don't mind at all.

           Linus
