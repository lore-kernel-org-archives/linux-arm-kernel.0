From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 08:39:15 +1300
Subject: [PATCH RESEND 3/6] clk: exynos: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <1355857917.24188.3.camel@gitbox>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-4-git-send-email-linux@prisktech.co.nz>
 <20121218183944.GH5032@mwanda> <1355856767.23479.3.camel@gitbox>
 <20121218190334.GK5032@mwanda> <1355857917.24188.3.camel@gitbox>
Message-ID: <1355859555.24188.6.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-19 at 08:11 +1300, Tony Prisk wrote:
> On Tue, 2012-12-18 at 22:03 +0300, Dan Carpenter wrote:
> > I don't care either way, but being different from the documentation
> > is less bad than crashing which is what your patch does.  Please
> > be more careful in the future.
> > 
> > regards,
> > dan carpenter
> 
> Critism accepted.
> 
> Given that the driver depends on (PLAT_SAMSUNG || ARCH_MULTIPLATFORM),
> and multiplatform select COMMON_CLK and PLAT_SAMSUNG is selected only by
> ARCH_S3C64XX which has HAVE_CLK I didn't see a problem here.
> 
> Your point is still valid and I will sort it out with Mike first.
> 
> Regards
> Tony P

Actually, I was wrong here - PLAT_SAMSUNG is selectable via

PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P

but all these options (or the options that select them) seem to select a
clock system as well, hence still no reason for a crash.

Regards
Tony P
