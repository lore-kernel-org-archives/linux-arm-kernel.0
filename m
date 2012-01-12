From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Jan 2012 07:32:54 +0100
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <CA+55aFxDdCUd_h2Xk3H3giO4GsAE05Y8-uN1tqRNOJiKV-mhGg@mail.gmail.com>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
 <7vty438575.fsf@alter.siamese.dyndns.org>
 <201201111812.46431.arnd@arndb.de>
 <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
 <CA+55aFxDdCUd_h2Xk3H3giO4GsAE05Y8-uN1tqRNOJiKV-mhGg@mail.gmail.com>
Message-ID: <CAMuHMdWnoKowa0atP0k5X4vukJTnQSNSh9gibxd1Y2e60qK3RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 00:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jan 11, 2012 at 12:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>
>> And all of this would look nice if you would have done a rebase on top of the
>> latest tagged version of Linus' tree that contains all prerequisites, right?
>
> Rebasing means that nobody else can depend on or work with that tree,
> so it's a no-no.
>
> Sure, it works if you are the only person touching it, but then you
> had better not export it at all, so what's the point?

That's why you need two branches:
  1. a non-rebasing one for development,
  2. a rebasing one containing cherry-picked (possibly folded) commits for
     preparing for upstream delivery.

Both branches contain an identical source tree at all times, but they contain
different commits. If you make a merge error in the first, or a rebase
error in the
second, you will notice as they will differ.

The non-rebasing branch should be used by your (sub)lieutenants to
base their work
on.
The rebasing branch is used for deliveries upstream. `for-next` and
`for-linus` are subsets of it. Patches emailed out for review
can/should come from this branch
(appying patches is also a form of rebasing).

> We have had independent problems in another branch exactly because it
> was rebased and people merged it, so bringing up rebasing as a
> "solution" is wrong-headed. It just causes *more* problems of other
> kinds, even if it may make git request-pull trivial.

Other people are supposed to merge the non-rebasing branch only. Just like
you (as in "everyone except Linus") only merge in your non-rebasing branch.

What I like (the most?) about git is that it tracks automatically what commits
in my rebasing branch have been applied upstream.

If you pull from your sub-lieutenants instead of applying patches, or if you
have multiple upstreams, it becomes more complicated, but I think git rebase
can still handle it.

Examples:
http://git.kernel.org/?p=linux/kernel/git/geert/linux-m68k.git;a=shortlog;h=refs/heads/master
(non-rebasing)
http://git.kernel.org/?p=linux/kernel/git/geert/linux-m68k.git;a=shortlog;h=refs/heads/m68k-queue
(rebasing)

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
