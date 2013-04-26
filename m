From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Apr 2013 08:42:58 -0700
Subject: [PATCH] clocksource: kona: adapt to CLOCKSOURCE_OF_DECLARE change
In-Reply-To: <1366732475-479886-5-git-send-email-arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-5-git-send-email-arnd@arndb.de>
Message-ID: <517AA082.8070806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-04-23 08:54 AM, Arnd Bergmann wrote:
> The CLOCKSOURCE_OF_DECLARE functions now take a device_node pointer
> as their argument, as of the clksrc/cleanup branch in arm-soc.
> This patch adapts the bcm_kona_timer driver to the new interface.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: John Stultz <john.stultz@linaro.org>
> ---
>   drivers/clocksource/bcm_kona_timer.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
> ...
>   
> -CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer",
> -	kona_timer_init);
> +CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer", kona_timer_init);
acked-by: Christian Daudt <csd@broadcom.com>
tested-by: Christian Daudt <csd@broadcom.com>

  thanks,
    csd
