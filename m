From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 14 Jul 2010 20:30:23 +0800
Subject: [PATCH 2/3] usb/{gadget,host}: Remove dead CONFIG_CPU_PXA27x
In-Reply-To: <e75b6cb0826c24f3c0583fb409473c494aff0f63.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
References: <cover.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<e75b6cb0826c24f3c0583fb409473c494aff0f63.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
Message-ID: <AANLkTimQnt8_OLGOp8VIUk6A10wBDNT3H_prpWNuYhc9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 7:32 PM, Christian Dietrich
<qy03fugy@stud.informatik.uni-erlangen.de> wrote:
> CONFIG_CPU_PXA27x doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
> ---
> ?drivers/usb/gadget/pxa27x_udc.c | ? 16 ----------------
> ?drivers/usb/host/ohci-pxa27x.c ?| ? ?8 --------
> ?2 files changed, 0 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
> index 85b0d89..73783f5 100644
> --- a/drivers/usb/gadget/pxa27x_udc.c
> +++ b/drivers/usb/gadget/pxa27x_udc.c
> @@ -2561,12 +2561,6 @@ static void pxa_udc_shutdown(struct platform_device *_dev)
> ? ? ? ? ? ? ? ?udc_disable(udc);
> ?}
>
> -#ifdef CONFIG_CPU_PXA27x

This should be CONFIG_PXA27x, I'll prepare a patch on this.
