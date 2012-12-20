From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 20 Dec 2012 11:00:11 -0800
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <20121220184525.GC21056@atomide.com>
References: <20121220163814.GA29557@quad.lixom.net>
 <20121220175639.GA14363@n2100.arm.linux.org.uk>
 <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
 <20121220184525.GC21056@atomide.com>
Message-ID: <CA+55aFyiRPk0Qta35PBqMFqn+GkKaugqKJM3WHCT0JEJ1YohWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 10:45 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> I'm seeing the "BUG: spinlock bad magic on CPU#0" issue
> reported and fixed here:
>
> http://marc.info/?l=linux-arm-kernel&m=135594868503683&w=2
>
> But that's probably been already posted as a proper patch
> somewhere?

Hmm. The patch there looks better than any alternative I can think of.
It uses the same spinlock name for the whole array, but I think it's
only used for lockdep printouts, so that should be fine.

Send me the patch with signed-off and tested-by, and perhaps have a
few more people test it. The powerpc and sparc people both use it in
their 32-bit versions and have responsible maintainers, so it might be
worth it double-checking with BenH and DaveM about it, just in case.
Added to the Cc.

                Linus
