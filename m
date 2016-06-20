From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 20 Jun 2016 13:08:54 -0400
Subject: [PATCH V2 36/63] clocksource/drivers/time-orion: Convert init
 function to return error
In-Reply-To: <1466112442-31105-37-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-37-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466442534.1887.7.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-06-16 at 23:26 +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
> 
>   or
> 
>   - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/time-lpc32xx.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
> index daae61e..cb5b866 100644
> --- a/drivers/clocksource/time-lpc32xx.c
> +++ b/drivers/clocksource/time-lpc32xx.c
> @@ -288,16 +288,16 @@ err_clk_enable:

[...]

Hi Daniel,

please update the patch subject
(i.e. replace "time-orion" by "time-lpc32xx).

You can add my "Acked-by" to the V3 patch:
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
