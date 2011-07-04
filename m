From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Mon, 4 Jul 2011 10:19:52 +0200
Subject: [RFC PATCH 0/3] base board consolidation
In-Reply-To: <20110701094403.GT11559@pengutronix.de>
References: <20110701094403.GT11559@pengutronix.de>
Message-ID: <201107041019.52847.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

(dropping Valentin in CC, as he is not working at epfl anymore)

> 
> Patch 2 keeps the existing kernel parameter for mx31moboard. That can be
> removed later as is done in patch 3. The latter shouldn't be applied now
> and is only included to improve the diffstat :-)

I would like to keep the mx31moboard parameter for compatibility reasons as 
some board are outside of epfl and are upgraded remotly without access to the 
bootloader. But I can keep the compatibility stuff in my tree if needed.

> 
> At some time this will probably be obsoleted by device tree stuff, the
> upside of this approach is that it already works today without the need
> to adapt the bootloader.

Yeah, I don't see much the point defining now a new common abstraction that 
will be obsoleted by the device tree.

Thanks,

Philippe

> 
> Best regards
> Uwe
> 
> The following changes since commit
> ca56a95eedcc95f8fea7b49c87565cd961d74fe2:
> 
>   Merge branch 'drm-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2011-06-29
> 18:18:48 -0700)
> 
> are available in the git repository at:
> 
>   git.ptx:/git/ukl/linux-2.6.git baseboardconsolidation
> 
> Uwe Kleine-K?nig (3):
>       ARM: common abstraction for specifying a baseboard
>       ARM: imx/mx31moboard: convert to new baseboard handling
>       ARM: imx/mx31moboard: remove obsolete baseboard handling
> 
>  Documentation/kernel-parameters.txt                |    2 +
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/common/baseboard.c                        |   58
> ++++++++++++++++++++ arch/arm/include/asm/baseboard.h                   | 
>  31 +++++++++++ arch/arm/mach-imx/Kconfig                          |    1
> +
>  arch/arm/mach-imx/mach-mx31moboard.c               |   38 +++++++-------
>  arch/arm/mach-imx/mx31moboard-devboard.c           |    5 +-
>  arch/arm/mach-imx/mx31moboard-marxbot.c            |    5 +-
>  arch/arm/mach-imx/mx31moboard-smartbot.c           |   18 ++----
>  arch/arm/plat-mxc/include/mach/board-mx31moboard.h |   16 ++----
>  11 files changed, 133 insertions(+), 45 deletions(-)
>  create mode 100644 arch/arm/common/baseboard.c
>  create mode 100644 arch/arm/include/asm/baseboard.h

-- 
Philippe R?tornaz
EPFL - STI - IMT - LSRO1
bureau MEB330, Station 9
CH-1015 Lausanne, Switzerland

tel: +41 21 693 78 42
fax: +41 21 693 78 07
http://lsro.epfl.ch
