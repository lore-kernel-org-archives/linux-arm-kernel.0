From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 17:30:04 +0000
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
In-Reply-To: <1287422635-21492-1-git-send-email-linus.walleij@stericsson.com>
References: <1287422635-21492-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110124173004.GA27080@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 07:23:55PM +0200, Linus Walleij wrote:
> This adds a small piece of code that displays some basic FPGA
> characteristics for the Integrator, Versatile, RealView and
> Versatile Express reference platforms, then hooks it into
> respective platform startup code.

Firstly, isn't this shown on the character LCD screen at boot, so I wonder
what the value of this is.

Secondly, with your revised patch, it could really do without adding more
non-timer stuff back into the timer initialization function when I've just
removed non-timer stuff from it.  I don't see that there's anything
particularly urgent about printing this information, so can't it be a
normal initcall?
