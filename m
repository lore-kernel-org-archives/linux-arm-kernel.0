From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 May 2013 22:59:55 -0700
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <519DCBEF.3090208@asianux.com> (Chen Gang's message of "Thu, 23
 May 2013 15:57:35 +0800")
References: <519DCBEF.3090208@asianux.com>
Message-ID: <877gio3okk.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Gang <gang.chen@asianux.com> writes:

> The crazy user can unset 'CONFIG_BUG' in menuconfig: "> General setup >
> Configure standard kernel features (expert users) > BUG() Support".
>
> But in fact, we always need it, and quite a few of architectures have
> already implemented it (e.g. alpha, arc, arm, avr32, blackfin, cris,
> frv, ia64, m68k, mips, mn10300, parisc, powerpc, s390, sh, sparc, x86).
>
> And kernel also already has prepared a default effective implementation
> for the architectures which is unwilling to implement it by themselves
> (e.g. arm64, c6x, h8300, hexagon, m32r, metag, microblaze, openrisc,
> score, tile, um, unicore32, xtensa).
>
> So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.


This looks like the right way to handle this to me.  If the BUG
annotations are too big and not needed they should simply be deleted
from the code base.  Disabling CONFIG_BUG which removes the BUG
annotations from the binaries without modifying the source code seems
like the wrong approach.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
