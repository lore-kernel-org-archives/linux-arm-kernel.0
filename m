From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 8 Aug 2012 23:27:34 +0800
Subject: [PATCH 1/6] ARM: pxa: remove irq_to_gpio from ezx-pcap driver
In-Reply-To: <1344430493-5304-2-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-2-git-send-email-arnd@arndb.de>
Message-ID: <CAN1soZy8nWpneqgbA7tdN-868WW8QC7SVHoGDRqyKz_=mTJEAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 8:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The irq_to_gpio function was removed from the pxa platform
> in linux-3.2, and this driver has been broken since.
>
> There is actually no in-tree user of this driver that adds
> this platform device, but the driver can and does get enabled
> on some platforms.
>
> Without this patch, building ezx_defconfig results in:
>
> drivers/mfd/ezx-pcap.c: In function 'pcap_isr_work':
> drivers/mfd/ezx-pcap.c:205:2: error: implicit declaration of function 'irq_to_gpio' [-Werror=implicit-function-declaration]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org (v3.2+)
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Daniel Ribeiro <drwyrm@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/mfd/ezx-pcap.c       |    2 +-
>  include/linux/mfd/ezx-pcap.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
