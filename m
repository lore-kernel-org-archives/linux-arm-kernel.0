From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 May 2014 04:37:30 +0000 (UTC)
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 12 Mar 2014, Tomi Valkeinen wrote:

> This patch adds hwmod data for omap5 display subsystem. I have tested this on
> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
> mainline is missing omap5 HDMI driver.
> 
> I do see this when booting:
> 
>   omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>   omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>   omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> 
> But at least DSI works just fine.

Am looking at this for v3.16.  But I think someone needs to take a look at 
those warnings and figure out why they are happening.

Is the soc_ops.wait_target_ready() call failing in omap_hwmod.c:_enable() 
? 


- Paul
