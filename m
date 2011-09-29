From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 29 Sep 2011 14:46:50 -0600 (MDT)
Subject: [PATCH v3 2/3] ARM: OMAP: TI814X: Add cpu type macros and
	detection support
In-Reply-To: <1317258560-30408-1-git-send-email-hemantp@ti.com>
References: <1317258560-30408-1-git-send-email-hemantp@ti.com>
Message-ID: <alpine.DEB.2.00.1109291443160.26728@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hemant,

a few comments:

On Thu, 29 Sep 2011, Hemant Pedanekar wrote:

> This patch adds cpu type, macros for identification of TI814X device.
> 
> Note that following update to common OMAP data structures is made:
> 
> cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
> clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to u16 from
> u8.
> 
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

Also, the opp2xxx.h change looks spurious, is that really needed?

Could you please split the clock-related changes into a separate patch?  
Then this patch would just be the id.c and cpu.h changes.

Other than that, the patch looks okay to me.


- Paul
