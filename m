From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 19:45:39 +0000
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
Message-ID: <201202281945.39419.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Rob Herring wrote:
> ixp2000 has no commits other than tree-wide changes or refactoring since
> 2006. No maintainer is listed for ixp2000 either.

I have this in my copy of the MAINTAINERS file:

ARM/INTEL IXP2000 ARM ARCHITECTURE
M:      Lennert Buytenhek <kernel@wantstofly.org>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained

It's missing an F: line, otherwise it suggests that the platform is still
maintained by Lennert and it certainly builds just fine. Unfortunately he
seems to have fallen off the edge of the planet at the end of last year.

> If this doesn't fly, my fallback to clean-up io.h is just removing
> CONFIG_IXP2000_SUPPORT_BROKEN_PCI_IO. According to the commit adding it
> (in 2005), it's only needed for pre-production revs which I would guess
> are all but gone by now.

My feeling is that we should keep ixp2000 around but get rid of the
workarounds for preproduction machines. If we can get Lennert to
reply, it should be his decision though.

	Arnd
