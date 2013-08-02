From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Aug 2013 16:41:11 -0700
Subject: Build breakage due to latest ARM fixes
Message-ID: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Looks like you sent up some fixes to Linus that broke one of the atmel
configs (CONFIG_MMU=n):

commit 48be69a026b2c1 ARM: move signal handlers into a vdso-like page

seems to have caused it:

arch/arm/kernel/signal.c: In function 'setup_return':
arch/arm/kernel/signal.c:413:25: error: 'mm_context_t' has no member
named 'sigpage'

I see it with at91x40_defconfig.


-Olof
