From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Oct 2016 17:45:33 -0200
Subject: [PATCH] hwrng: meson: Fix module autoload for OF registration
In-Reply-To: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
References: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAOMZO5B+iDyNJ-heFU2Th-HQHocLS3Lz5zV7hFhiLs7ESJt2gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 5:40 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:

> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -32,7 +32,7 @@ config TCG_TIS_CORE
>
>  config TCG_TIS
>         tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface"
> -       depends on X86
> +       depends on X86 || COMPILE_TEST

This is a separate change.
