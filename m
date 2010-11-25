From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 24 Nov 2010 17:40:17 -0800
Subject: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
In-Reply-To: <1290524213-395-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Tue, 23 Nov 2010 20:26:42 +0530")
References: <1290524213-395-1-git-send-email-charu@ti.com>
Message-ID: <87lj4i2nb2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
> module uses hwmod FW.
>
> Tested on OMAP2430, OMAP44430, OMAP3430 SDP boards, OMAP4430 Blaze board
> and zoom3 board. Verified that this patch series does not break the OMAP1
> build.
>
> Version History:
> ---------------
> v7 Series:
> - Use gpio iclks as main_clk in OMAP3 & OMAP4
> - Implement GPIO as a platform device (use hwmod FW for OMAP2+)
>  and the implementation is similar to current GPIO code. Does not
>  modify the gpio suspend/ resume/ prepare for odle and resume after
>  idle code and these modifications would be done in a separate patch
>  series. This was suggested by Kevin in another internal email thread.

OK, I'm ready to merge this series, and we can deal with the runtime PM
conversion in another series as that's where the tricky part lies.

However, I'd like one more rebase/retest due to some other dependencies.
Can you rebase/retest using my current pm-core branch?   That includes
several dependencies that are also targetted for 2.6.38:

- misc. PM fixes
- i2c hwmod + runtime PM conversion (my pm-hwmod-i2c branch)
- several board file changes/updates (Tony's devel-board branch)
- hwmod core fixes (Paul's hwmod_a_2.6.38 branch)
- wdt hwmod cleanups (Paul's wdt_2.6.38 branch)

Also, can you collect the acks from Beno?t and update your changelogs to
include them.  Thanks.

Please be sure your board file changes are updated for the board file
changes in the devel-board branch.

Thanks, 

Kevin
