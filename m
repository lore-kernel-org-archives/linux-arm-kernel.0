From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Feb 2012 22:48:14 +0000
Subject: [PATCH] ARM: iop: add missing includes
In-Reply-To: <1329344682-29962-1-git-send-email-olof@lixom.net>
References: <1329344682-29962-1-git-send-email-olof@lixom.net>
Message-ID: <20120215224814.GG27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 02:24:42PM -0800, Olof Johansson wrote:
> Resolves two build breaks. One is a boatload of "unknown type name 'u32'"
> in iop3xx.h due to missing include of <linux/types.h>.
> 
> The other is:
> arch/arm/plat-iop/restart.c: In function 'iop3xx_restart':
> arch/arm/plat-iop/restart.c:18:2: error: implicit declaration of function 'soft_restart' [-Werror=implicit-function-declaration]

Hmm, I think system.h has become quite a mess over the years.

I should've done something about that with the restart changes, and
created an asm/restart.h - the entire kernel doesn't need to know about
our soft restart stuff.  Looks like there aren't that many users so at
least that kind of cleanup would be relatively simple.
