From: wni@nvidia.com (Wei Ni)
Date: Fri, 6 Jul 2012 11:08:15 +0800
Subject: [PATCH 5/5] ARM: tegra: enable wireless in defconfig
In-Reply-To: <4FF5F20F.2050005@wwwdotorg.org>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
 <1341394488-13169-6-git-send-email-wni@nvidia.com>
 <4FF5F20F.2050005@wwwdotorg.org>
Message-ID: <1341544095.3484.33.camel@tegra-chromium-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-06 at 03:59 +0800, Stephen Warren wrote:
> On 07/04/2012 03:34 AM, Wei Ni wrote:
> > New options enabled:
> > * WIRELESS: (dependency)
> > * CFG80211: (dependency)
> > * WLAN: (dependency)
> > * BRCMFMAC: wlan driver, enable as module.
> 
> > diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> 
> > +CONFIG_BRCMFMAC=m
> 
> Why does this need to be a module? Everything else in tegra_defconfig is
> built-in, and it'd be nice to be consistent here. Built-in makes
> net-booting new kernels from U-Boot much easier, since there aren't any
> modules to copy.
> 
> When I built a kernel with this series, I observed the following:
> 
> CONFIG_BRCMFMAC=m
> 
> * Neither Cardhu nor Ventana auto-load the module. When the module is
> manually modprobe'd, I still see no wireless device being created.
> 
> CONFIG_BRCMFMAC=y
> 
> * Cardhu: No wireless device created. I do see some kernel spew such as
> "mmc1: queuing unknown CIS tuple 0x80" which I believe is the SDIO
> device being probed, but I don't see any Linux device being created.
> 
> * Ventana: There's a 60s hang during boot, I believe related to the BRCM
> driver, since the hang doesn't occur without the series.
> 
> In summary, this series doesn't work at all for me. Can you please
> explain what you tested and how? Are there any differences between the
> various Cardhu and Ventana board revisions and/or the 2 different
> wireless cards possible on Cardhu that'd explain this?

I have verified this patch, it can work on these boards.
The t30/t20 version on my Cardhu and Ventana is A02, the wireless chip
is bcm4329. I didn't test on other boards, and I'm not sure if the
bcm4330 can work.
When you test, you need to copy the latest brcmfmac firmware to the
filesystem.
Please get it from:
http://linuxwireless.org/en/users/Drivers/brcm80211#Firmware_installation-1

You can run "ifconfig -a" to show the "wlan0" device.

> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
