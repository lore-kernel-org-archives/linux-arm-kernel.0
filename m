From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Feb 2012 08:41:07 -0800
Subject: [PATCH 3/3] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
In-Reply-To: <20120216101123.GI15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182829.18884.69168.stgit@kaulin.local>
 <20120216101123.GI15338@n2100.arm.linux.org.uk>
Message-ID: <20120216164106.GC15692@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120216 01:40]:
> On Wed, Feb 15, 2012 at 10:28:30AM -0800, Tony Lindgren wrote:
> > Now that omap hsmmc init is split into two functions, it's safe
> > to mark omap_hsmmc_init and omap_mux related functions to __init.
> > 
> > This basically reverts the following fixes for the case where
> > TWL was compiled as a module:
> > 
> > d5de63 (ARM: omap: preemptively fix section mismatch in omap4_sdp4430_wifi_mux_init())
> 
> Why did you include this one?  This is unrelated to the TWL problems.

Oops sorry, thanks for noticing. Your patch makes it __init,
I was reading the patch wrong way around. Your patch should
stay and my patch now changes it the wrong way.

Regards,

Tony
