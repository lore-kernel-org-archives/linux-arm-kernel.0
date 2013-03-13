From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Mar 2013 11:19:46 +0000
Subject: [PATCH v5 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1363144715-12002-1-git-send-email-shawn.guo@linaro.org>
References: <1363001737-8745-3-git-send-email-shawn.guo@linaro.org>
 <1363144715-12002-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201303131119.46580.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 March 2013, Shawn Guo wrote:
> build, the patch turns uncompress debug into one part of DEBUG_LL
> support.  When DEBUG_LL is turned on for a particular platform,
> uncompress debug works too for that platform.
> 
> OMAP and Tegra are exceptions here.  OMAP low-level debug code places
> data in the .data section, and that is not allowed in decompressor.
> And Tegra code has reference to variable that's unavailable in
> decompressor but only in kernel.  That's why Kconfig symbol
> DEBUG_UNCOMPRESS controlling multiplatform uncompress debug support is
> defined with !DEBUG_OMAP2PLUS_UART && !DEBUG_TEGRA_UART.
> 
> It creates arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
> included there, implements a generic putc() using those macros, which
> will be built when DEBUG_UNCOMPRESS is defined.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
