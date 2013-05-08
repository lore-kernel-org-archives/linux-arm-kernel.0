From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 7 May 2013 17:59:56 -0700
Subject: [GIT PULL 4/5] ARM: arm-soc: late cleanups
In-Reply-To: <20130507231925.GR28721@atomide.com>
References: <1367947574-2934383-1-git-send-email-arnd@arndb.de>
 <1367947574-2934383-5-git-send-email-arnd@arndb.de>
 <20130507231925.GR28721@atomide.com>
Message-ID: <CA+55aFxHZSYV3UZMf+ezADX5z2psLm5a9Wpp6qcDQho7n2J6SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 7, 2013 at 4:19 PM, Tony Lindgren <tony@atomide.com> wrote:
>
>> Vaibhav Hiremath (1):
>>       ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a
>
> Turns out this urgent boot fix got undone in the merge somehow.

Those lines actually disappeared already much earlier in my merge 6fa52ed33bea:

    Merge tag 'drivers-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

last Saturday.

And it's my bad. I even know how it happened: I ended up doing that
merge twice (because I had to go back and fix something else), and
then I "optimized" it the second time. With all the omap2 conflicts
from that tree came from duplicate commits from the ARM tree, and I
ended up just taking the drivers-for-linus side for
arch/arm/mach-omap2. Which was correct for the other two files in
there (gpmc.c and gpmc-onenand.c). but the timer.c file had changes
from the arm tree.

Sorry about that one.

                 Linus
