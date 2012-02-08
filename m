From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:47:39 -0800
Subject: [PATCH 08/16] ARM: omap: fix section mismatch warning in mux.c
In-Reply-To: <E1RvAXN-0006HJ-RK@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAXN-0006HJ-RK@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208184739.GH29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:07]:
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x15a4): Section mismatch in reference from the function omap_mux_init_signals() to the function .init.text:omap_mux_init_signal()
> The function omap_mux_init_signals() references
> the function __init omap_mux_init_signal().
> This is often because omap_mux_init_signals lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I'll separate out the muxing part for v3.4. For the -rc series:

Acked-by: Tony Lindgren <tony@atomide.com>
