From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 30 Dec 2009 01:19:41 -0700 (MST)
Subject: [PATCH] [OMAP1] Clock fixups for OMAP1 and OMAP7xx
In-Reply-To: <1261528641-22465-1-git-send-email-darkstar6262@gmail.com>
References: <6cb013310912221628m1b2b820fy1a96a9a9102274e5@mail.gmail.com>
	<1261528641-22465-1-git-send-email-darkstar6262@gmail.com>
Message-ID: <alpine.DEB.2.00.0912300116350.24862@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cory,

On Tue, 22 Dec 2009, Cory Maccarrone wrote:

> This change adds in some missing clocks that were needed as a result
> of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
> mach-omap1/clock_data.c).  Prior to this, it was just assumed that
> these clocks existed for all devices, and it was used directly instead
> of calling it out with a clk_get call.  So, not having the CK_7XX
> meant these clocks weren't being used anymore for omap 7xx devices,
> which broke things badly.
> 
> Additionally, that change added an __initdata decoration to the
> structure containing the clk_enable and clk_disable functions.  Once
> init data was freed, these pointers went to null, and the next enable
> or disable call caused the kernel to crash.  This change removes
> this decoration.

Could you please split these two patches, since they fix different 
problems?  Also the first patch is pertinent only to OMAP7xx-family 
chips and the second is OMAP1-wide.  I've already got your first patch, so 
no need to resend that.

thanks,

- Paul
