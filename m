From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 10:12:09 +0200
Subject: [PATCH v2 1/9] pinctrl: walk into bcm subdir unconditionally
In-Reply-To: <1464934708-24769-2-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-2-git-send-email-kraxel@redhat.com>
Message-ID: <CACRpkdZKii2QR2TWYZdG-cdTn2UeVDcE3d39xPffWwipHcthpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 8:18 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:

> There is no ARCH_BCM on arm64, and we need pinctrl-bcm2835 for the rpi3.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/pinctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e4bc115..88586c0 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_PINCTRL_TB10X)   += pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_ST)       += pinctrl-st.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)     += pinctrl-zynq.o
>
> -obj-$(CONFIG_ARCH_BCM)         += bcm/
> +obj-y                          += bcm/

Looks OK to me, but would like Stephen's or Eric's ACK?

Yours,
Linus Walleij
