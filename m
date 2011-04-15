From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 20:36:54 +0100
Subject: [RFC] sanitizing crazy clock data files
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110415193654.GP1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:08:05PM +0200, Sascha Hauer wrote:
> The following tries to solve the chicken-egg problem we have with the
> common struct clk support and its users.

Thanks for doing this.  This really shows exactly what I wanted to know.

>  drivers/clk/Kconfig                     |    6 +
>  drivers/clk/Makefile                    |    2 +
>  drivers/clk/clk-divider.c               |  132 +++
>  drivers/clk/clk-mux.c                   |   92 ++
>  drivers/clk/clk.c                       |  104 ++
>  include/linux/clk.h                     |   68 ++
>  16 files changed, 1395 insertions(+), 1831 deletions(-)

If we can have more people using the generic mux and divider stuff,
that should cut many more hundreds of LOC from arch/arm.

This is exactly the kind of stuff we need to be seeing.

1. How does this fit in with the other MX stuff?
2. Is it based upon Jeremy's git tree, and is Jeremy's git tree a stable
   base for this?
3. Is this sufficiently separated that it can be pulled as-is?
