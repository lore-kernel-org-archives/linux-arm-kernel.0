From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 4 Apr 2011 14:46:56 +0800
Subject: [PATCH 2/2] pcmcia: limit pxa2xx_trizeps4 subdriver to trizeps4
	platform
In-Reply-To: <1301650126-6992-2-git-send-email-dbaryshkov@gmail.com>
References: <1301650126-6992-1-git-send-email-dbaryshkov@gmail.com>
	<1301650126-6992-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <BANLkTikkn2XQYZ4ET80zmpqCroVjadNbOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 5:28 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> pxa2xx_trizeps4 tries to register pxa2xx-pcmcia device not checking whether
> machine is really trizeps4, thus messing multi-machine kernels. Fix it up.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Applied.

> ---
> ?drivers/pcmcia/pxa2xx_trizeps4.c | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
> index b7e5966..5bb4e1a 100644
> --- a/drivers/pcmcia/pxa2xx_trizeps4.c
> +++ b/drivers/pcmcia/pxa2xx_trizeps4.c
> @@ -226,6 +226,9 @@ static int __init trizeps_pcmcia_init(void)
> ?{
> ? ? ? ?int ret;
>
> + ? ? ? if (!machine_is_trizeps4() && !machine_is_trizeps4wl())
> + ? ? ? ? ? ? ? return -ENODEV;
> +
> ? ? ? ?trizeps_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
> ? ? ? ?if (!trizeps_pcmcia_device)
> ? ? ? ? ? ? ? ?return -ENOMEM;
> --
> 1.7.4.1
>
>
