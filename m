From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Aug 2012 01:03:55 -0300
Subject: [PATCH] ARM: mxs_defconfig: Enable USB host
In-Reply-To: <201208060555.08447.marex@denx.de>
References: <1344186258-30841-1-git-send-email-festevam@gmail.com>
 <20120806025806.GA22302@S2101-09.ap.freescale.net>
 <CAOMZO5CevtbEdch5v9jt5Gyis8o6C1-Vrm1p=289Gpx4zd_wxQ@mail.gmail.com>
 <201208060555.08447.marex@denx.de>
Message-ID: <CAOMZO5BBXwOME2MadkLwf=xJnTQ_djjXbNMkjA9yau1q4x_zgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 12:55 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dear Fabio Estevam,
>
>> On Sun, Aug 5, 2012 at 11:58 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > I guess you did not run savedefconfig.  We do not need all those
>> > options explicitly added there.
>>
>> No, I have not run savedefconfig. What is the correct way to use it?
>
> make mxs_config
> <edit>
> make savedefconfig
>
> I'd guess ...

So the generating diff would be:
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ccdb635..a9556ef 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -95,7 +95,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_DISPLAY_SUPPORT=m
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_TIMER=y
@@ -110,6 +110,13 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_USB=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
-- 
1.7.1

Is this OK?

Regards,

Fabio Estevam
