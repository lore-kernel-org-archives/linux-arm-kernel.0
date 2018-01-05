From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 11:42:26 +0100
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.16
In-Reply-To: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
References: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAK8P3a28vqr_zxOXWhECtohYCqMH15Jc_AEA2eb8iSr5D0_9Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 1, 2018 at 7:53 AM, Andy Gross <andy.gross@linaro.org> wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.16
>
> for you to fetch changes up to d2fa1f37d21bf9729ae9ee79cb6bfc8de1f0a9a4:
>
>   arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY (2017-12-21 13:28:11 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Based defconfig Updates for v4.16
>
> * Remove legacy QCOM config options
>
> ----------------------------------------------------------------
> Alex Elder (3):
>       arm64: defconfig: remove CONFIG_USB_EHCI_MSM
>       arm64: defconfig: remove CONFIG_USB_MSM_OTG
>       arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

Thanks for taking care of this, merged into next/soc.

I wonder what the long-term plan is for the other drivers/usb/phy drivers now
that one more has been removed.
I just checked what's left there and found:

a) many users of usb-nop-xceiv
b) a few drivers in use on actively maintained platforms (ti,am335x-usb-phy,
    ti,twl6030-usb, ti,keystone-usbphy, fsl,imx23-usbphy,
nvidia,tegra20-usb-phy)
c) some more drivers used only by very old platforms (fsl-usb2-otg, gpio-vbus,
    mv-otg, isp1301, isp1301_omap, omap_otg, tahvo-usb)

I assume nobody is touching the ones in category c) any more, but should
we encourage the ones using category a) and b) to get replaced with
drivers/phy/ drivers like the Qualcomm ones were?

     Arnd
