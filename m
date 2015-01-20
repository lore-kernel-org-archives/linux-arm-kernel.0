From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Jan 2015 08:11:56 -0700
Subject: [PATCH] coresight-etm: remove check for unknown Kconfig macro
In-Reply-To: <1421689454.9655.58.camel@x220>
References: <1421689454.9655.58.camel@x220>
Message-ID: <CANLsYkzgiX_ZkQVEU-o4VE=LQB=daw1a3WCOkm45bdBHWg72tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 January 2015 at 10:44, Paul Bolle <pebolle@tiscali.nl> wrote:
> The CoreSight ETM/PTM driver contains a check for a
> CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE macro. But there's no related
> Kconfig symbol CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE. Remove that check
> and the single line of code it hides.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Cross-compile tested only (on top of next-20150119).
>
>  drivers/coresight/coresight-etm3x.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
> index 73c36696f1b6..f312dc4dd95c 100644
> --- a/drivers/coresight/coresight-etm3x.c
> +++ b/drivers/coresight/coresight-etm3x.c
> @@ -34,11 +34,7 @@
>
>  #include "coresight-etm.h"
>
> -#ifdef CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
> -static int boot_enable = 1;
> -#else
>  static int boot_enable;
> -#endif
>  module_param_named(
>         boot_enable, boot_enable, int, S_IRUGO
>  );
> --
> 1.9.3
>

Applied - with a slight modification to keep the "module_param_named"
macro on the same line.
