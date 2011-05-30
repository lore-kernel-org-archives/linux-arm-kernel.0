From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 May 2011 22:51:32 +0100
Subject: [PATCH 1/2] mach-u300: fix compilation error in timer
In-Reply-To: <1306764491-28369-1-git-send-email-linus.walleij@stericsson.com>
References: <1306764491-28369-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110530215132.GA21382@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 04:08:11PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The introduction of the mmio timer accidentally referenced the
> old clocksource struct which does not exist anymore. Fix this by
> using a simple string instead. This also fixes a compilation
> warning by casting the address to (void __iomem *).

Please fix your #defines for IOMEM addresses instead of adding
explicit casts where its used.
