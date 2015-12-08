From: drinkcat@chromium.org (Nicolas Boichat)
Date: Tue, 8 Dec 2015 12:52:33 +0800
Subject: [PATCH v2 2/3] nvmem: mediatek: Add Mediatek EFUSE driver
In-Reply-To: <1447930014-19579-3-git-send-email-andrew-ct.chen@mediatek.com>
References: <1447930014-19579-1-git-send-email-andrew-ct.chen@mediatek.com>
 <1447930014-19579-3-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <CANMq1KBKfO6pP4nZ4XBSpeG8b1AHd9Co9KqxW3CRbtZvfJJNDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 6:46 PM, Andrew-CT Chen
<andrew-ct.chen@mediatek.com> wrote:
> Add Mediatek EFUSE driver to access hardware data like
> thermal sensor calibration or HDMI impedance.
>
> Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> ---
>  drivers/nvmem/Kconfig     | 11 ++++++
>  drivers/nvmem/Makefile    |  2 ++
>  drivers/nvmem/mtk-efuse.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/nvmem/mtk-efuse.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index bc4ea58..ea7ec17 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -36,6 +36,17 @@ config NVMEM_MXS_OCOTP
>           This driver can also be built as a module. If so, the module
>           will be called nvmem-mxs-ocotp.
>
> +config MTK_EFUSE

Nit: I think this entry should be between NVMEM_IMX_OCOTP and
NVMEM_MXS_OCOTP (looks like NVMEM_ prefix is ignored in the ordering).

> [snip]

The rest looks good.
