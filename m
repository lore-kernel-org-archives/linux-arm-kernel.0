From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 08:56:14 +0800
Subject: [PATCH] PCI: imx6: fix imprecise abort handler
In-Reply-To: <201310190333.52772.marex@denx.de>
References: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
 <201310190333.52772.marex@denx.de>
Message-ID: <20131021005612.GC17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 19, 2013 at 03:33:52AM +0200, Marek Vasut wrote:
> Dear Tim Harvey,
> 
> > An imprecise abort is triggered when a port behind a switch is accessed
> > and no device is present.  At enumeration, imprecise aborts are not enabled
> > thus this ends up getting deferred until the kernel has completed init.  At
> > that point we must not adjust PC - the handler must do nothing, but a
> > handler must exist.
> > 
> > This fixes random crashes that occur right after freeing init.
> > This is against linux-pci/host-imx6.
> > 
> > Acked-by: Marek Vasut <marex@denx.de>
> > Tested-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Expanding CC a bit, let's have more eyes on this.
> 

Acked-by: Shawn Guo <shawn.guo@linaro.org>
