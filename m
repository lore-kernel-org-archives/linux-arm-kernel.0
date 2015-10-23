From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 15:09:04 +0200
Subject: [PATCH v3 3/7] vfio: platform: introduce
 module_vfio_reset_handler macro
In-Reply-To: <1445603835-14506-4-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-4-git-send-email-eric.auger@linaro.org>
Message-ID: <3721718.lcvGuESNdi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:37:11 Eric Auger wrote:
> +static int __init reset ## _module_init(void)                  \
> +{                                                              \
> +       vfio_platform_register_reset(compat, reset);            \
> +       return 0;                                               \
> +};                                                             \
> 

I would make this 'return vfio_platform_register_reset(...)', so loading
the driver fails if the handler cannot get registered. Alternatively,
change the return type of vfio_platform_register_reset to 'void'
so it can never fail.

	Arnd
