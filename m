From: mathieu.malaterre@gmail.com (Mathieu Malaterre)
Date: Wed, 22 Jun 2016 09:55:49 +0200
Subject: [PATCH] usb: renesas_usbhs: make usbhs_write32() static
In-Reply-To: <1466531574-3096-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466531574-3096-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CA+7wUsxSypNQTCQ-p0VkD=dciPFDGKCX6WGqhFjQ_CEbcTZ0fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 7:52 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The usbhs_write32 function is not used outside of the rcar3.c
> file, so fix the following sparse warning by making it static:
>
> drivers/usb/renesas_usbhs/rcar3.c:26:6: warning: symbol 'usbhs_write32' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/usb/renesas_usbhs/rcar3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/renesas_usbhs/rcar3.c b/drivers/usb/renesas_usbhs/rcar3.c
> index 38b01f2..1d70add 100644
> --- a/drivers/usb/renesas_usbhs/rcar3.c
> +++ b/drivers/usb/renesas_usbhs/rcar3.c
> @@ -23,7 +23,7 @@
>  #define UGCTRL2_RESERVED_3     0x00000001      /* bit[3:0] should be B'0001 */
>  #define UGCTRL2_USB0SEL_OTG    0x00000030
>
> -void usbhs_write32(struct usbhs_priv *priv, u32 reg, u32 data)
> +static void usbhs_write32(struct usbhs_priv *priv, u32 reg, u32 data)
>  {
>         iowrite32(data, priv->base + reg);
>  }
> --
> 2.8.1

static inline ?
