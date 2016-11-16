From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Nov 2016 13:58:53 -0800
Subject: [PATCH 1/2] staging: vc04_services: remove duplicate
 mutex_lock_interruptible
In-Reply-To: <20161116154139.3703209-1-arnd@arndb.de>
References: <20161116154139.3703209-1-arnd@arndb.de>
Message-ID: <87y40j9jdu.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The driver tries to redefine mutex_lock_interruptible as an open-coded
> mutex_lock_killable, but that definition clashes with the normal
> mutex_lock_interruptible definition when CONFIG_DEBUG_LOCK_ALLOC
> is set:

These two are:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161116/a24ca915/attachment.sig>
