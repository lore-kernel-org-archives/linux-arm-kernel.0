From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 7 Jul 2010 21:12:22 +0400
Subject: [PATCH RFC 0/4] ARM/KGDB: Some fixes for SMP machines
Message-ID: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

It appears that KGDB can easily hang SMP ARM machines.

Here are few fixes that I come up with.

Before the patches, doing 'b schedule' and then 1-3 'continue'
or 'si' gdb commands would cause the board to lock-up completely.

After the patches, KGDB seems to be bullet proof. Well, at least
with the 'b schedule' testcase, there might be other bugs which
I didn't hit yet. ;-)

Notes:

1. I'm testing with I/D caches disabled. With enabled caches,
   ARMv6K still locks-up. I'll test ARMv7 soon, and will try
   to debug cache issues on ARMv6K.

2. The patches are against a heavily patched kernel, and so far
   I didn't rebase them onto the 'debug core' rework as found
   in the very latest mainline kernels. I'll rebase the patches
   soon, so for now this is just an RFC.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
