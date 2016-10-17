From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 17 Oct 2016 09:40:30 -0700
Subject: [PATCH 3/5] [media] rc: meson-ir: Fix module autoload
In-Reply-To: <1476719053-17600-4-git-send-email-javier@osg.samsung.com>
References: <1476719053-17600-1-git-send-email-javier@osg.samsung.com>
 <1476719053-17600-4-git-send-email-javier@osg.samsung.com>
Message-ID: <CAOi56cWAaQ51mQG2LrQEg5B4aRcLFzOZAn9hPtGK06xXj0sHmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 8:44 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
>
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>
> Before this patch:
>
> $ modinfo drivers/media/rc/meson-ir.ko | grep alias
> $
>
> After this patch:
>
> $ modinfo drivers/media/rc/meson-ir.ko | grep alias
> alias:          of:N*T*Camlogic,meson-gxbb-irC*
> alias:          of:N*T*Camlogic,meson-gxbb-ir
> alias:          of:N*T*Camlogic,meson8b-irC*
> alias:          of:N*T*Camlogic,meson8b-ir
> alias:          of:N*T*Camlogic,meson6-irC*
> alias:          of:N*T*Camlogic,meson6-ir
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
