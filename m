From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2012 10:22:17 -0700
Subject: [PATCH 4/9] ARM: omap2+: fix building without i2c
In-Reply-To: <1332522836-29517-5-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120323172216.GB9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A trivial typo causes build breakage when I2C is disabled
> and omap_i2c_reset is set to NULL on OMAP:
> 
> omap_hwmod_44xx_data.c:2287:11: error: lvalue required as unary '&' operand
> 
> Removing the '&' character solves this.

We are now building in the omap_i2c_reset always, so this
should be revalidated. We currently don't have NULL version
of omap_i2c_reset any longer, so those '&' for functions are
mostly cosmetic right now.

Anyways, at least the commit message should be changed to
be current.

Regards,

Tony
