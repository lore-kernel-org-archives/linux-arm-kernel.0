From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 14 Dec 2015 12:27:16 +0800
Subject: [PATCH v2 0/3] Mediatek EFUSE Support
In-Reply-To: <1447930014-19579-1-git-send-email-andrew-ct.chen@mediatek.com>
References: <1447930014-19579-1-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <CAGS+omA8XK6ksd7Ma8yAUbkSsHR6yQxjFrV+HGbd83UiH6T51g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Thu, Nov 19, 2015 at 6:46 PM, Andrew-CT Chen
<andrew-ct.chen@mediatek.com> wrote:
> This patch adds EFUSE support driver which is used by other drivers
> like thermal sensor and HDMI impedance.
>
> There are some efuses these fuses store things like calibration data,
> speed bins.. etc. Drivers like thermal sensor, HDMI impedance would
> read out this data for configuring the driver.
>
> Change in v2:
> 1. Rebase to 4.4-rc1
> 2. Modify the driver Makefile for more consistent with other drivers
> 3. Modify the compatible string to "mediatek,mt8173-efuse" and "mediatek,efuse"

Do you still plan to queue this for v4.5?

>
> Andrew-CT Chen (3):
>   dt-bindings: add document of mediatek efuse driver
>   nvmem: mediatek: Add Mediatek EFUSE driver
>   dts: arm64: Add EFUSE device node
>
>  .../devicetree/bindings/nvmem/mtk-efuse.txt        | 36 +++++++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  5 ++
>  drivers/nvmem/Kconfig                              | 11 +++
>  drivers/nvmem/Makefile                             |  2 +
>  drivers/nvmem/mtk-efuse.c                          | 89 ++++++++++++++++++++++
>  5 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>  create mode 100644 drivers/nvmem/mtk-efuse.c
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
