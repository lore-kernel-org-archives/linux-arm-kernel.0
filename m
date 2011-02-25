From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 25 Feb 2011 13:47:32 +0300
Subject: [PATCH 1/3] pxa: Enable pxa-pcm-audio on pxa210/pxa25x platform
In-Reply-To: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
References: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <AANLkTimD28SYLA=NZyEO8SS==wrZ2mL+LG92e6FGHtom@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric, will it be possible to get at least this patch in the kernel?

Otherwise all ASoC-based audio on pxa25x isn't working.

On 2/23/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> pxa25x platforms were left out of major ASoC Update patch.
> Since f0fba2ad1b a registration of pxa-pcm-audio device is required for
> ASoC to function on pxa platforms. Register one also for pxa210/pxa25x.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/mach-pxa/pxa25x.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index fbc5b77..b166b1d 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -347,6 +347,7 @@ static struct platform_device *pxa25x_devices[]
> __initdata = {
>  	&pxa25x_device_assp,
>  	&pxa25x_device_pwm0,
>  	&pxa25x_device_pwm1,
> +	&pxa_device_asoc_platform,
>  };
>
>  static struct sys_device pxa25x_sysdev[] = {
> --
> 1.7.2.3
>
>


-- 
With best wishes
Dmitry
