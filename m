From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 6 May 2013 17:39:09 +0200
Subject: [PATCH v3 5/7] ARM: kirkwood: remove legacy mv643xx_eth board
 setup
In-Reply-To: <1367854420-8006-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367854420-8006-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130506173909.10dc7c59@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon,  6 May 2013 17:33:38 +0200, Sebastian Hesselbarth wrote:
> With DT support for mv643xx_eth we do not need legacy platform_data
> based setup for DT enabled boards. This patch removes eth setup
> for all kirkwood DT board files.
> 

>  arch/arm/mach-kirkwood/board-dnskw.c          |    7 -------
>  arch/arm/mach-kirkwood/board-dockstar.c       |    9 ---------
>  arch/arm/mach-kirkwood/board-dreamplug.c      |   14 --------------
>  arch/arm/mach-kirkwood/board-goflexnet.c      |    9 ---------
>  arch/arm/mach-kirkwood/board-guruplug.c       |   14 --------------
>  arch/arm/mach-kirkwood/board-ib62x0.c         |    9 ---------
>  arch/arm/mach-kirkwood/board-iconnect.c       |    6 ------
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   16 ----------------
>  arch/arm/mach-kirkwood/board-km_kirkwood.c    |    7 -------
>  arch/arm/mach-kirkwood/board-lsxl.c           |   12 ------------
>  arch/arm/mach-kirkwood/board-mplcec4.c        |   11 -----------
>  arch/arm/mach-kirkwood/board-ns2.c            |   13 -------------
>  arch/arm/mach-kirkwood/board-openblocks_a6.c  |    9 ---------
>  arch/arm/mach-kirkwood/board-readynas.c       |    6 ------
>  arch/arm/mach-kirkwood/board-ts219.c          |   13 -------------
>  arch/arm/mach-kirkwood/board-usi_topkick.c    |    9 ---------

I believe a good number of those files become empty once you've removed
the registration of the Ethernet devices. Shouldn't such files be
removed in this patch?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
