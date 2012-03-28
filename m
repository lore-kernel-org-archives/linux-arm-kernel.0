From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2012 20:58:19 +0000
Subject: [GIT PULL 4/5] ARM: More device tree support updates
In-Reply-To: <CA+55aFy4QNiDTL2b37Y870kZ-09sFp9qsFn+SaKCbzWqm8xtoQ@mail.gmail.com>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <1332918842-13521-5-git-send-email-olof@lixom.net>
 <CA+55aFy4QNiDTL2b37Y870kZ-09sFp9qsFn+SaKCbzWqm8xtoQ@mail.gmail.com>
Message-ID: <201203282058.20226.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 March 2012, Linus Torvalds wrote:
> On Wed, Mar 28, 2012 at 12:14 AM, Olof Johansson <olof@lixom.net> wrote:
> >
> > Merge conflicts and proposed solutions:
> >
> > arch/arm/mach-ux500/Kconfig: Two new config options. Keep both.
> 
> Guys, I'm seeing merge problems that go way beyond this.
> 
> Look at that MACH_U8500 config option. It got renamed to MACH_MOP500,
> but it continues to live in the tree.
> 
> This rename conflict happened earlier and I didn't notice (grep for
> it: it's used by a staging driver), so it's already in my pushed out
> tree. But it seems to be getting worse, and your proposed merge
> solution doesn't cover it.

Your solution looks good. I had the MACH_UX500_DT option above U5500
instead of below it in our for-next branch, but either way makes sense.

> I'll try to fix things up, but you need to verify my merge. And you
> guys should have noticed and noted it, rather than leave it to my
> random bumbling about.

Yes, noted for next time. We had a lot of merge conflicts because of
being relatively late in the merge window (this one was purely
self made though), and it's not always easy to decide which ones
to eliminate in advance, leave in or describe the resolution we found.

Since we usually see the same conflicts and resolve them in the
for-next branch, I guess it's easy enough to just always provide
the branch with the resolutions as a help for cases like this one.

	Arnd
