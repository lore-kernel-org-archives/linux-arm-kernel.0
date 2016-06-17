From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Jun 2016 08:58:28 +0200
Subject: [PATCH V2 62/63] clocksource/drivers/oxnas-rps: Convert init
 function to return error
In-Reply-To: <1466112442-31105-63-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-63-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <57639F94.9010400@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 11:27 PM, Daniel Lezcano wrote:
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
>  drivers/clocksource/timer-oxnas-rps.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
