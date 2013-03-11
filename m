From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Mar 2013 10:36:55 -0700
Subject: [PATCH v4 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1363001737-8745-3-git-send-email-shawn.guo@linaro.org>
References: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
 <1363001737-8745-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130311173655.GQ26093@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [130311 04:39]:
> Instead of giving zero support of uncompress debug for multiplatform
> build, the patch turns uncompress debug into one part of DEBUG_LL
> support.  When DEBUG_LL is turned on for a particular platform,
> uncompress debug works too for that platform.
> 
> OMAP is an exception here.  OMAP low-level debug code places data
> in the .data section, and that is allowed in decompressor.  That's
> why Kconfig symbol DEBUG_UNCOMPRESS that controls multiplatform
> uncompress debug support is defined with !DEBUG_OMAP2PLUS_UART.

This seems like a good solution for now. Later on we can rip out
the use .data for omap and just rely on ifdefs for all the port
variables if we conclude that we won't try to attempt any runtime
autodetection for omaps. So for both patches:

Acked-by: Tony Lindgren <tony@atomide.com>
