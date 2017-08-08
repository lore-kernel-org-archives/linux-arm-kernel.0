From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Aug 2017 12:14:13 +0100
Subject: [PATCH v2 1/5] mfd: mt6397: create irq mappings in mfd core driver
In-Reply-To: <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
 <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
Message-ID: <20170808111413.qt6qc2w6l6gdihpu@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 07 Aug 2017, Chen Zhong wrote:

> The core driver should create and manage irq mappings instead of
> leaf drivers. This patch change to pass irq domain to
> devm_mfd_add_devices() and it will create mapping for irq resources
> automatically. And remove irq mapping in rtc driver since this has
> been done in core driver.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |    4 ++--
>  drivers/rtc/rtc-mt6397.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Once you've fixed Dmitry's comment:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
