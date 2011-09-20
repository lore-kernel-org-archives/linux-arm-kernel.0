From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 09:16:33 +0200
Subject: [PATCH v2 0/3] ARM: imx: Add cpuidle for imx platforms
In-Reply-To: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
Message-ID: <20110920071633.GR31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Fri, Sep 16, 2011 at 12:27:47PM -0500, Robert Lee wrote:
> This patch series adds a common imx cpuidle driver, some common 
> mach-mx5 level cpuidle functionality, and an i.MX51 instance of
> using this driver.
> 
> The patch series is based on v3.1-rc2.
> 
> Changes since v1:
> * To address all the problems found during review of v1, a complete
> re-write was needed.

Much better than the last version, thanks.

> 
> Robert Lee (3):
>   ARM: imx: Add imx cpuidle driver
>   ARM: imx: Add cpuidle for mach-mx5
>   ARM: imx: Add cpuidle for i.MX51
> 
>  arch/arm/mach-mx5/Makefile               |    3 +-
>  arch/arm/mach-mx5/cpu_op-mx51.c          |   35 +++++++-

Your additions to this file...

>  arch/arm/mach-mx5/cpu_op-mx51.h          |    1 +
>  arch/arm/mach-mx5/mm.c                   |    4 +
>  arch/arm/mach-mx5/system.c               |   35 +++++++

And this one should go to arch/arm/mach-mx5/cpuidle.c, then we have
all i.MX5 specific cpuidle stuff together without ifdeffing the code.
I assume that cpuidle support for i.MX53 will look identically, right?

>  arch/arm/plat-mxc/Makefile               |    1 +
>  arch/arm/plat-mxc/cpuidle.c              |  151 ++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/cpuidle.h |   56 +++++++++++
>  arch/arm/plat-mxc/include/mach/system.h  |    3 +
>  9 files changed, 286 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/cpuidle.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h
> 
> 

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
