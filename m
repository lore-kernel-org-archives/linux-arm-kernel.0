From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:48:16 -0800
Subject: [PATCH 09/16] ARM: omap: preemptively fix section mismatch in
 omap4_sdp4430_wifi_mux_init()
In-Reply-To: <E1RvAXi-0006HN-9X@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAXi-0006HN-9X@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208184816.GI29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:07]:
> Found by review.
> 
> omap4_sdp4430_wifi_mux_init() is called by an __init marked function,
> and only calls omap_mux_init_gpio() and omap_mux_init_signal() which
> are both also an __init marked functions.
> 
> The only reason this doesn't issue a warning is because the compiler
> inlines omap4_sdp4430_wifi_mux_init() into omap4_sdp4430_wifi_init().
> 
> So, lets add the __init annotation to ensure this remains safe should
> the compiler choose not to inline.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
