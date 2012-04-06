From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 15:49:45 +0800
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120406074942.GO7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 07:58:40PM +0100, Mark Brown wrote:
> The AMBA bus regulator support is being used to model on/off switches
> for power domains which isn't terribly idiomatic for modern kernels with
> the generic power domain code and creates integration problems on platforms
> which don't use regulators for their power domains as it's hard to tell
> the difference between a regulator that is needed but failed to be provided
> and one that isn't supposed to be there (though DT does make that easier).
> 
> Platforms that wish to use the regulator API to manage their power domains
> can indirect via the power domain interface.
> 
> This feature is only used with the vape supply of the db8500 PRCMU
> driver which supplies the UARTs and MMC controllers, none of which have
> support for managing vcore at runtime in mainline (only pl022 SPI
> controller does).  Update that supply to have an always_on constraint
> until the power domain support for the system is updated so that it is
> enabled for these users, this is likely to have no impact on practical
> systems as probably at least one of these devices will be active and
> cause AMBA to hold the supply on anyway.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Russell,

I believe this patch fixes the amba probe failure that impacts any
AMBA platform build with CONFIG_REGULATOR enabled.  Could you consider
to send the fix for -rc soon?

The patch "ARM: amba: adapt to regulator probe deferral change" from
me could be ignored now.

-- 
Regards,
Shawn
