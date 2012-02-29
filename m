From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 14:55:20 +0000
Subject: [PATCH] rpmsg: fix build warning when compiling 64-bit
In-Reply-To: <1330527004-12503-1-git-send-email-mark.asselstine@windriver.com>
References: <1330527004-12503-1-git-send-email-mark.asselstine@windriver.com>
Message-ID: <201202291455.20688.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Mark Asselstine wrote:
> dev_dbg() in rpmsg_probe() made use of the %x formatting
> which expects an 'unsigned int' which dma_addr_t is not
> when compiling for 64-bit. Casting to a 'void *' and
> using %p will avoid this and not force an upcast to a
> 64-bit value for 32-bit builds.

This does not work on 32-bit platforms with a 64-bit dma_addr_t
though. Better cast to unsigned long long and print using 0x%llx.

	Arnd
