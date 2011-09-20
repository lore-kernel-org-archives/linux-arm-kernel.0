From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 20 Sep 2011 12:07:48 +0300
Subject: [PATCH 00/10] hwspinlock-next
In-Reply-To: <1315846025-11453-1-git-send-email-ohad@wizery.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Message-ID: <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> This series includes a new u8500 hwspinlock driver from Mathieu,
> a core fix from Juan and several other cleanups/fixes
> (some of which were reported by Arnd while reviewing Mathieu's
> driver).
...
> ?Documentation/hwspinlock.txt ? ? ? ? ? ? | ? 74 +++++++-----
> ?MAINTAINERS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 15 +++
> ?arch/arm/mach-omap2/hwspinlock.c ? ? ? ? | ? ?8 +-
> ?drivers/hwspinlock/Kconfig ? ? ? ? ? ? ? | ? 27 +++--
> ?drivers/hwspinlock/Makefile ? ? ? ? ? ? ?| ? ?2 +
> ?drivers/hwspinlock/hwspinlock_core.c ? ? | ?204 +++++++++++++++++++-----------
> ?drivers/hwspinlock/hwspinlock_internal.h | ? 40 ++++--
> ?drivers/hwspinlock/omap_hwspinlock.c ? ? | ?127 +++++++------------
> ?drivers/hwspinlock/u8500_hsem.c ? ? ? ? ?| ?198 +++++++++++++++++++++++++++++
> ?include/linux/hwspinlock.h ? ? ? ? ? ? ? | ? 46 +++++--
> ?10 files changed, 516 insertions(+), 225 deletions(-)

I'm wondering how hwspinlock updates like this should go upstream.

The first hwspinlock batch was picked by Tony, because it involved a
bulk of OMAP changes.

Hwspinlock isn't OMAP-specific anymore though (we gained support for
STE's u8500) and the vast majority of changes are in drivers/. We're
still very much ARM-related, though this may change too at some point
(c6x has a similar "hardware semaphore" peripheral like the u8500
does).

Tony, if you're still willing to pick up these updates I'd be happy to
send you pull requests of course.

Otherwise, I'll appreciate if anyone has any suggestions ?

I'll of course set up a tree for this and ask Stephen to take it to
linux-next as expected (unless someone just prefers to pick up the
acked patches into his tree).

Thanks,
Ohad.
