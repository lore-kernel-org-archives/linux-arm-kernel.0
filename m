From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 4 Apr 2011 14:47:21 +0800
Subject: [PATCH 1/2] pcmcia: limit pxa2xx_balloon3 subdriver to balloon3
	platform
In-Reply-To: <1301650126-6992-1-git-send-email-dbaryshkov@gmail.com>
References: <1301650126-6992-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <BANLkTimKrpJxdzoRWDGApvXDhXGPwXUFOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 5:28 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> pxa2xx_balloon3 tries to register pxa2xx-pcmcia device not checking whether
> machine is really balloon3, thus messing multi-machine kernels. Fix it up.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Applied.

> ---
> ?drivers/pcmcia/pxa2xx_balloon3.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
> index 453c54c..4c3e94c 100644
> --- a/drivers/pcmcia/pxa2xx_balloon3.c
> +++ b/drivers/pcmcia/pxa2xx_balloon3.c
> @@ -25,6 +25,8 @@
>
> ?#include <mach/balloon3.h>
>
> +#include <asm/mach-types.h>
> +
> ?#include "soc_common.h"
>
> ?/*
> @@ -127,6 +129,9 @@ static int __init balloon3_pcmcia_init(void)
> ?{
> ? ? ? ?int ret;
>
> + ? ? ? if (!machine_is_balloon3())
> + ? ? ? ? ? ? ? return -ENODEV;
> +
> ? ? ? ?balloon3_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
> ? ? ? ?if (!balloon3_pcmcia_device)
> ? ? ? ? ? ? ? ?return -ENOMEM;
> --
> 1.7.4.1
>
>
