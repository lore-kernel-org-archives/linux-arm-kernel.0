From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 17:43:47 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <519CE651.6070209@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221718.53759.arnd@arndb.de> <519CE651.6070209@free-electrons.com>
Message-ID: <201305221743.47679.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Gregory CLEMENT wrote:
> Loosing the earlyprintk would be a big regression. Having DEBUG_LL disabled
> in multiplatform case is fine.

EARLY_PRINTK depends on DEBUG_LL, so that makes no sense.

> If the kernel seems to not run at all we
> can still build a kernel for only for mvebu, activate earlyprintk and see
> what happened. With your proposal we won't have any more this feature, and
> it will make the debug or the bug report for the user much harder. As we still
> in active development I really want to avoid it.

I don't understand. You should still be able to turn on DEBUG_LL when you need
it. It will just work only on the machines it is configured for, as it always
does. You will need a separate Kconfig option for each physical address though,
but that is also nothing new.

	Arnd
