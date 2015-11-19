From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 00:43:31 +0100
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in sunxi_defconfig
In-Reply-To: <1447969715.1730.5.camel@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447969715.1730.5.camel@silentcreek.de>
Message-ID: <20151119234331.GT32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 19, 2015 at 10:48:35PM +0100, Timo Sigurdsson wrote:
> Hi Maxime,
> Hi Chen-Yu,
> 
> Am Dienstag, den 17.11.2015, 02:42 +0100 schrieb Timo Sigurdsson:
> > Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
> > framework") moved the the sunxi SID driver to a new framework, but left
> > sunxi_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> > instead of the new symbold NVMEM_SUNXI_SID. Hence, re-enable the driver
> > in sunxi_defconfig.
> > 
> > While at it, clean up sunxi_defconfig by generating a fresh file via
> >   make sunxi_defconfig
> >   make savedefconfig
> > While this moves around a few lines and removes unnecessary symbols,
> > it doesn't introduce any functional changes.
> > 
> > Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> > 
> > diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> > index 3c36e16..904ea52 100644
> > --- a/arch/arm/configs/sunxi_defconfig
> > +++ b/arch/arm/configs/sunxi_defconfig
> > @@ -11,14 +11,12 @@ CONFIG_SMP=y
> >  CONFIG_NR_CPUS=8
> >  CONFIG_AEABI=y
> >  CONFIG_HIGHMEM=y
> > -CONFIG_HIGHPTE=y
> >  CONFIG_ARM_APPENDED_DTB=y
> >  CONFIG_ARM_ATAG_DTB_COMPAT=y
> >  CONFIG_CPU_FREQ=y
> >  CONFIG_CPUFREQ_DT=y
> >  CONFIG_VFP=y
> >  CONFIG_NEON=y
> > -CONFIG_PM=y
> >  CONFIG_NET=y
> >  CONFIG_PACKET=y
> >  CONFIG_UNIX=y
> > @@ -37,7 +35,6 @@ CONFIG_CAN_SUN4I=y
> >  # CONFIG_WIRELESS is not set
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> > -CONFIG_EEPROM_SUNXI_SID=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_ATA=y
> >  CONFIG_AHCI_SUNXI=y
> > @@ -63,11 +60,10 @@ CONFIG_STMMAC_ETH=y
> >  # CONFIG_INPUT_MOUSEDEV is not set
> >  # CONFIG_INPUT_KEYBOARD is not set
> >  # CONFIG_INPUT_MOUSE is not set
> > -CONFIG_INPUT_MISC=y
> > -CONFIG_INPUT_AXP20X_PEK=y
> >  CONFIG_INPUT_TOUCHSCREEN=y
> > -CONFIG_KEYBOARD_SUN4I_LRADC=y
> >  CONFIG_TOUCHSCREEN_SUN4I=y
> > +CONFIG_INPUT_MISC=y
> > +CONFIG_INPUT_AXP20X_PEK=y
> >  CONFIG_SERIAL_8250=y
> >  CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_8250_NR_UARTS=8
> > @@ -123,6 +119,8 @@ CONFIG_PWM=y
> >  CONFIG_PWM_SUN4I=y
> >  CONFIG_PHY_SUN4I_USB=y
> >  CONFIG_PHY_SUN9I_USB=y
> > +CONFIG_NVMEM=y
> > +CONFIG_NVMEM_SUNXI_SID=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_VFAT_FS=y
> >  CONFIG_TMPFS=y
> 
> Would you also prefer to see this patch split up into two patches (one
> for re-enabling the SID driver and one for the extra cleanup of
> sunxi_defconfg) as I was asked to do for my other patch for
> multi_v7_defconfig?

Yes, please do.

Also why CONFIG_PM CONFIG_KEYBOARD_SUN4I_LRADC and CONFIG_HIGHPTE got
removed ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/cdf3bdc5/attachment.sig>
