From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Sep 2012 00:07:04 +0000 (UTC)
Subject: [PATCH V2 4/7] ARM: OMAP: Add a timer attribute for timers that
 can interrupt the DSP
In-Reply-To: <1347579091-3794-5-git-send-email-jon-hunter@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <1347579091-3794-5-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1209192356570.14850@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Sep 2012, Jon Hunter wrote:

> Some instances of the DMTIMER peripheral on OMAP devices have the ability
> to interrupt the on-chip DSP in addition to the ARM CPU. Add a DMTIMER
> attribute to indicate which timers can interrupt the DSP. By using the
> omap_dm_timer_request_by_cap() API, driver will now be able to allocate
> a DMTIMER that can interrupt the DSP based upon this attribute and not require
> the driver to know which instance has this capability.
> 
> DMTIMERs that have the ability to interrupt the DSP on OMAP devices are as
> follows ...
> 
> - OMAP1 (OMAP5912/16xx/17xx) devices	- All 8 DMTIMERs
> - OMAP2/3/4 devices			- DMTIMERs 5-8
> 
> Please note that for OMAP3+, timer8 has the ability to interrupt the DSP and
> generate a PWM output.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.7.

- Paul
