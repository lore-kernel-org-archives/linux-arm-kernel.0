From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jul 2010 09:48:56 +0100
Subject: [PATCH RFC 0/4] ARM/KGDB: Some fixes for SMP machines
In-Reply-To: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
References: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
Message-ID: <004701cb1e7a$66a78890$33f699b0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

> It appears that KGDB can easily hang SMP ARM machines.

Yep. As pointed out at:

http://lkml.org/lkml/2010/4/8/214

Commit ae6bf53e broke kgdb on SMP systems because it incorrectly assumes
that atomic_{inc,dec} imply barriers. Until this is fixed, it will never
work reliably on ARM. Try reverting the patch [this doesn't completely
resolve the situation, but it might help].

> 1. I'm testing with I/D caches disabled. With enabled caches,
>    ARMv6K still locks-up. I'll test ARMv7 soon, and will try
>    to debug cache issues on ARMv6K.

This patch might help if you're using the ARM11MPCore:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016567.html

Hope that helps,

Will
