From: dhowells@redhat.com (David Howells)
Date: Tue, 05 Nov 2013 11:11:36 +0000
Subject: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
In-Reply-To: <52786742.1080509@asianux.com>
References: <52786742.1080509@asianux.com> <51FB6216.6010008@asianux.com>
 <11907.1383602624@warthog.procyon.org.uk>
Message-ID: <13981.1383649896@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Chen Gang <gang.chen@asianux.com> wrote:

> > Userspace sometimes depends on the name in the guard macro:-/
> 
> "the guard macro" is only for prevent itself from being included by
> multiple times (an id used by itself -- like a handle), it is not an id
> to let other files know about it (it is not a normal using way).

Whilst that *should* be true, it isn't actually true.  See:

	grep -r _LINUX_.*_H /usr/include/ | grep -v ^/usr/include/linux/

for example.  Also who knows what all those autoconf scripts out there look
for?

However, thinking about it some more, you're probably safe with respect to
userspace as scripts/headers_install.h strips off the _UAPI prefix on the
guard macros - just as long as you don't change the rest of the macro name.

David
