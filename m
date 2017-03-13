From: rick.chang@mediatek.com (Rick Chang)
Date: Mon, 13 Mar 2017 11:04:54 +0800
Subject: [PATCH] [media] vcodev: mediatek: add missing include in JPEG
 decoder driver
In-Reply-To: <20170312201329.28357-1-jeremy.lefaure@lse.epita.fr>
References: <20170312201329.28357-1-jeremy.lefaure@lse.epita.fr>
Message-ID: <1489374294.19716.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-03-12 at 16:13 -0400, J?r?my Lefaure wrote:
> The driver uses kzalloc and kfree functions. So it should include
> linux/slab.h. This header file is implicitly included by v4l2-common.h
> if CONFIG_SPI is enabled. But when it is disabled, slab.h is not
> included. In this case, the driver does not compile:
> 
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c: In function ?mtk_jpeg_open?:
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:8: error: implicit
> declaration of function ?kzalloc?
> [-Werror=implicit-function-declaration]
>   ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>         ^~~~~~~
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:6: warning:
> assignment makes pointer from integer without a cast [-Wint-conversion]
>   ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>       ^
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1047:2: error: implicit
> declaration of function ?kfree? [-Werror=implicit-function-declaration]
>   kfree(ctx);
>   ^~~~~
> 
> This patch adds the missing include to fix this issue.
> 
> Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rick Chang <rick.chang@mediatek.com>
