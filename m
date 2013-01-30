From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 23:15:22 +0000
Subject: [GIT PULL] ux500 <mach/id.h> removal
In-Reply-To: <CACRpkdYmTTgpnAOoNM3RJiF_oADgbuGK-vw6JF8J9rPAttA5PQ@mail.gmail.com>
References: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
 <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
 <CACRpkdYmTTgpnAOoNM3RJiF_oADgbuGK-vw6JF8J9rPAttA5PQ@mail.gmail.com>
Message-ID: <201301302315.22357.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Linus Walleij wrote:
> On Wed, Jan 30, 2013 at 1:12 AM, Olof Johansson <olof@lixom.net> wrote:
> > [Me]
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> >> tags/ux500-no-idh
> >
> > Pulled in.
> >
> > This has a somewhat annoying (but trivial) conflict against your own
> > code (the cpufreq driver changes).
> 
> Arnd always told me to split stuff cleanly on branches, which of course
> leads to conflicts like that, but I thought he wanted them, rather than
> huge accumulated patch sets built on to of each othere ... a bit hard to
> do the right thing here, what would have been the right way?
> 
> Does it help if I base stuff off ARM SoC tree branches, and which
> ones can be relied upon in that case?

Not sure if it applies here, but in a lot of cases, one can extract the
parts that do conflict and put those patches first in the series, and
merge them together before the pull request.

The classic example of this is two independent features A and B that
both contain some cleanup. By moving the cleanup first, you can merge
the cleanup-A patches with the cleanup-B patches and submit them as one
branch, and then have feature A on top of cleanup-A merge cleanly with
both feature-B (because there are no conflicts) and with cleanup-A-B
(because cleanup-A-B has already resolved the conflict).

Unrelated to this: The mach/id.h removal seems to have caused a few
build errors in the for-next tree with u8500_defconfig. Can you have
a look at what went wrong there?

	Arnd
