From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 10:17:34 +0100
Subject: [PATCH 5/9] gpio/nomadik: use typesafe __io_address()
In-Reply-To: <1335172482-27648-1-git-send-email-linus.walleij@stericsson.com>
References: <1335172482-27648-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120423091733.GJ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 11:14:42AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We were using a custom io_p2v() (physical-to-virtual) translation
> macro, but with the advent of the cross-platform __io_address()
> let us try to get rid of this. Inspired by a similar patch by
> Jonas Aberg.

Is there any point to io_p2v() or __io_address() anymore?  Won't ioremap()
do here?
