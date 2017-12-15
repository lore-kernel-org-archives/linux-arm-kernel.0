From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 14:55:50 -0600
Subject: [PATCH 1/7] soc: mediatek: Add USB wakeup driver
In-Reply-To: <1512809136-2779-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
 <1512809136-2779-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20171215205550.dkiymkok6arheidg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 09, 2017 at 04:45:30PM +0800, Chunfeng Yun wrote:
> This driver is used to support usb wakeup which is controlled by
> the glue layer between SSUSB and SPM. Usually the glue layer is put
> into a system controller, such as pericfg module, which is
> represented by a syscon node in DTS.
> Due to the glue layer may vary on different SoCs, it's useful to
> extract a separated driver to simplify usb controller drivers.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig                  |   8 +
>  drivers/soc/mediatek/Makefile                 |   1 +
>  drivers/soc/mediatek/mtk-usb-wakeup.c         | 519 ++++++++++++++++++++++++++
>  include/dt-bindings/soc/mediatek,usb-wakeup.h |  15 +

This belongs in the binding patch and that should come first.

>  include/linux/soc/mediatek/usb-wakeup.h       |  88 +++++
>  5 files changed, 631 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-usb-wakeup.c
>  create mode 100644 include/dt-bindings/soc/mediatek,usb-wakeup.h
>  create mode 100644 include/linux/soc/mediatek/usb-wakeup.h

> +++ b/drivers/soc/mediatek/mtk-usb-wakeup.c
> @@ -0,0 +1,519 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0

This should be the first line of the file and use a // style comment.

[...]

> diff --git a/include/dt-bindings/soc/mediatek,usb-wakeup.h b/include/dt-bindings/soc/mediatek,usb-wakeup.h
> new file mode 100644
> index 0000000..2461795
> --- /dev/null
> +++ b/include/dt-bindings/soc/mediatek,usb-wakeup.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0

ditto. Except headers use /* */ comments...
