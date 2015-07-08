From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Jul 2015 22:54:49 +0800
Subject: [PATCH] ARM: imx6: gpc: always enable PU domain if CONFIG_PM is
 not set
In-Reply-To: <1435668504-26945-1-git-send-email-l.stach@pengutronix.de>
References: <1435668504-26945-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20150708145449.GI28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 02:48:24PM +0200, Lucas Stach wrote:
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

Applied, thanks. 
