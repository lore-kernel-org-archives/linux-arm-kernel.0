From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 10:27:55 +0000
Subject: [PATCH] clk: Add axi-clkgen driver
In-Reply-To: <50FFB4D8.5060801@metafoo.de>
References: <1357755120-32735-1-git-send-email-lars@metafoo.de>
 <20130122175552.24671.27893@quantum> <50FFB4D8.5060801@metafoo.de>
Message-ID: <20130123102755.GP23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:00:56AM +0100, Lars-Peter Clausen wrote:
> I think I read somewhere at some point that ioread{8,16,32} is preferred
> over write{b,h,l} in new code.

But... there's *no* point using ioread*() if you don't only use the
ioremap() interface.

ioread*() is there to allow PC IO and PC MMIO accesses through one
accessor depending on the cookie.  ioremap() only ever returns cookies
for MMIO accesses.
