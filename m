From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 01 Jul 2015 12:13:57 +0200
Subject: [PATCH] ARM: imx6: gpc: always enable PU domain if CONFIG_PM is
 not set
In-Reply-To: <1435668504-26945-1-git-send-email-l.stach@pengutronix.de>
References: <1435668504-26945-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1435745637.3860.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 30.06.2015, 14:48 +0200 schrieb Lucas Stach:
> If CONFIG_PM is not set the PU power domain needs to be enabled always,
> otherwise there are two failure scenarios which will hang the system if
> one of the devices in the PU domain is accessed.
> 
> 1. New DTs (4.1+) drop the "always-on" property from the PU regulator, so
> if it isn't properly enabled by the GPC code it will be disabled at the
> end of boot.
> 
> 2. If the bootloader already disabled the PU domain the GPC explicitly
> needs to enable it again, even if the kernel doesn't do any power
> management. This is a bit hypothetical, as it requires to boot a
> mainline kernel on a downstream bootloader, as no mainline bootloader
> disables the PM domains.
> 
> Cc: <stable@vger.kernel.org> # 4.1
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/gpc.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
