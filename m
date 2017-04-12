From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Apr 2017 15:26:43 -0300
Subject: [PATCH -next] imx7: fix Kconfig warning and build errors
In-Reply-To: <47fc2167-bf0a-866a-e075-8247a10aa6e0@infradead.org>
References: <47fc2167-bf0a-866a-e075-8247a10aa6e0@infradead.org>
Message-ID: <CAOMZO5CF4GZx2UWxq3SF_=g9hnSS9A28T4tPLaSHQr-qJs623Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 3:22 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> --- linux-next-20170412.orig/drivers/soc/imx/Kconfig
> +++ linux-next-20170412/drivers/soc/imx/Kconfig
> @@ -2,6 +2,7 @@ menu "i.MX SoC drivers"
>
>  config IMX7_PM_DOMAINS
>         bool "i.MX7 PM domains"
> +       depends on PM
>         select PM_GENERIC_DOMAINS

Could this be:

select PM_GENERIC_DOMAINS if PM instead?
