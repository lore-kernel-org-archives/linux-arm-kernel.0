From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 15:36:05 +0800
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <1321977265-14959-1-git-send-email-b29396@freescale.com>
References: <a>
 <1321977265-14959-1-git-send-email-b29396@freescale.com>
Message-ID: <20111124073605.GI17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:54:22PM +0800, Dong Aisheng wrote:
[...]
> Dong Aisheng (3):
>   ARM: mxs: add saif clkmux functions
>   ARM: mx28evk: add platform data for saif
>   ARM: mx28evk: set a initial clock rate for saif
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |   38 +++++++++++++++++++++++
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 ++-
>  arch/arm/mach-mxs/include/mach/common.h         |    1 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++-
>  arch/arm/mach-mxs/include/mach/digctl.h         |   21 ++++++++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   18 +++++++++-
>  7 files changed, 84 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
> 
Applied, thanks.

During the testing, the saif driver's dependency on
REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
in sound/soc/mxs/Kconfig rather than leaving it to users.

-- 
Regards,
Shawn
