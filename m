From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2016 13:58:43 +0200
Subject: [PATCH 2/2] armv8: aarch32: Add SMP support for 32-bit Linux
 kernel
In-Reply-To: <1474597146-33312-2-git-send-email-b18965@freescale.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <1474597146-33312-2-git-send-email-b18965@freescale.com>
Message-ID: <1728374.uyXUDC3UK8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 23, 2016 10:19:06 AM CEST Alison Wang wrote:
> The patch adds SMP support for running 32-bit Linux kernel for
> Layerscape platforms. Spin-table method is used for SMP support.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>  arch/arm/mach-imx/common.h          |  1 +
>  arch/arm/mach-imx/mach-layerscape.c |  1 +
>  arch/arm/mach-imx/platsmp.c         | 49 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 

This really shouldn't be needed: if it works on a 64-bit kernel
without platform specific SMP operations, why do you need it on 32-bit
kernels?

	Arnd
