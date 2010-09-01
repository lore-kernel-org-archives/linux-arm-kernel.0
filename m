From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 00:23:07 +0100
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100901232307.GC25860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 04:01:59PM +0200, Linus Walleij wrote:
> From: Per Fransson <per.xx.fransson@stericsson.com>
> 
> This implementation of cpu_v7_reset flushes the L1 cache
> and turns off the MMU.

NAK - this is wrong.  Please check the updates I made to the shutdown code
(which already deal with the cache flushing and turning off cacheability.)

The only thing this should be doing is turning off the MMU and jumping to
the provided pointer.
