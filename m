From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 20 Jun 2016 13:32:15 +0200
Subject: [PATCH V2 47/63] clocksource/drivers/timer-stm32: Convert init
 function to return error
In-Reply-To: <1466112442-31105-48-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-48-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CALszF6AfU3js=xzSjtACc_H+bbYXBgXXtnVb3H+BwXAr7zzOZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-16 23:27 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
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
>  drivers/clocksource/timer-stm32.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)


Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
