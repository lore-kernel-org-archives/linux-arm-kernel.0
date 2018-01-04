From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 4 Jan 2018 12:06:56 +0000
Subject: [PATCH V2] ARM: imx_v6_v7_defconfig: select the CONFIG_CPUFREQ_DT
In-Reply-To: <CAOMZO5DnSVKvteBtNB5RqXg3v0kV889w9eDOw=rjx90SiiPx1A@mail.gmail.com>
References: <1515091174-30944-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DnSVKvteBtNB5RqXg3v0kV889w9eDOw=rjx90SiiPx1A@mail.gmail.com>
Message-ID: <AM3PR04MB1315E44CFC98BBA6F79F5075F51F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2018-01-04 7:37 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> King - ARM Linux <linux@armlinux.org.uk>; linux-kernel <linux-
> kernel at vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH V2] ARM: imx_v6_v7_defconfig: select the
> CONFIG_CPUFREQ_DT
> 
> On Thu, Jan 4, 2018 at 4:39 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> 
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> > b/arch/arm/configs/imx_v6_v7_defconfig
> > index 29cd1ac..885db90 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -58,6 +58,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> >  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> >  CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > +CONFIG_CPUFREQ_DT=y
> >  CONFIG_ARM_IMX6Q_CPUFREQ=y
> >  CONFIG_CPU_IDLE=y
> >  CONFIG_VFP=y
> > @@ -318,14 +319,6 @@ CONFIG_USB_CONFIGFS_F_MIDI=y
> > CONFIG_USB_CONFIGFS_F_HID=y  CONFIG_USB_CONFIGFS_F_UVC=y
> > CONFIG_USB_CONFIGFS_F_PRINTER=y -CONFIG_USB_ZERO=m -
> CONFIG_USB_AUDIO=m
> > -CONFIG_USB_ETH=m -CONFIG_USB_G_NCM=m -
> CONFIG_USB_GADGETFS=m
> > -CONFIG_USB_FUNCTIONFS=m -CONFIG_USB_MASS_STORAGE=m
> > -CONFIG_USB_G_SERIAL=m
> 
> Not sure why these are getting removed automatically.
> 
> >  CONFIG_MMC=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_PLTFM=y
> > @@ -350,7 +343,6 @@ CONFIG_RTC_DRV_PCF8563=y
> CONFIG_RTC_DRV_M41T80=y
> > CONFIG_RTC_DRV_MC13XXX=y  CONFIG_RTC_DRV_MXC=y
> > -CONFIG_RTC_DRV_MXC_V2=y
> 
> This is the rtc driver for mx53.
> 
> This driver will land in 4.16, so that's the reason it got removed automatically by
> savedefconfig.
> 
> It would be safer if your patch could only add a single line:
> 'CONFIG_CPUFREQ_DT=y'.

Thanks Fabio, I send a V3 patch with the only change.

Anson.
