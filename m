From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Dec 2011 21:53:12 -0800
Subject: [GIT PULL] at91: drivers for 3.3
In-Reply-To: <4EEA0DF6.3050408@atmel.com>
References: <4EEA0DF6.3050408@atmel.com>
Message-ID: <CAOesGMjurPDXVR1FLmLXa5NDNjpTzGpshQQ0piqHis5wsYM=Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 15, 2011 at 7:10 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof,
>
> This is a first "drivers" part of our material for 3.3 merge window. It collects
> Ethernet drivers changes.
> One thing to note is that the macb.c driver is modified to support
> device tree. We agreed with David to drag those modifications into
> arm-soc git tree because they go on top of Jamie's work on macb-gem driver
> already in your drivers/macb-gem branch.
>
> This pull request goes on top of Linus' 3.2-rc5 commit but with additional
> dependencies with two of your branches:
> 1/ fixes (which seems already included in 3.2-rc5)
> 2/ drivers/macb-gem
>
> I had to resolve a conflict while merging the macb-gem branche with current 3.2-rc5. The
> resolution is commited into this branch.
> Tell me if you need more precision.

The history of this branch due to the double dependencies gets a bit
awkward. Also, it seems like you in one of your merges kept the
'default y' in NET_CADENCE that should have been removed.

Would you mind trying this instead?

* Base this new branch on the previous macb-gem branch
* Cherry-pick the fixes from 'fixes' into the new branch if truly
needed -- I tested here and all of the patches applied cleanly.
* Then apply these patches
* For build testing before sending, merge into for-next to aggregate
with the rest of the 'fixes' changes -- it's OK that we have to do a
fixup here.

That should give a clean branch with neat history for just these
changes. About 'fixes': Since they are in for-next, and will be in
3.2, that dependency will be taken care of that way.

Then send a fresh pull request for that new branch, please.


Thanks!


-Olof
