From: john.stultz@linaro.org (John Stultz)
Date: Thu, 28 Mar 2013 11:01:38 -0700
Subject: [PATCH V7 1/2] ARM: bcm281xx: Add timer driver (driver portion)
In-Reply-To: <1363210048-3334-1-git-send-email-csd@broadcom.com>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
Message-ID: <51548582.1000507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 02:27 PM, Christian Daudt wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>
> Updates from V6:
> - Split DT portion into a separate patch
>
> Updates from V5:
> - Rebase to latest arm-soc/for-next
>
> Updates from V4:
> - Switch code to use CLOCKSOURCE_OF_DECLARE
>
> Updates from V3:
> - Migrate to 3.9 timer framework updates
>
> Updates from V2:
> - prepend static fns + fields with kona_
>
> Updates from V1:
> - Rename bcm_timer.c to bcm_kona_timer.c
> - Pull .h into bcm_kona_timer.c
> - Make timers static
> - Clean up comment block
> - Switched to using clockevents_config_and_register
> - Added an error to the get_timer loop if it repeats too much
> - Added to Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
> - Added missing readl to timer_disable_and_clear
>
> Note: bcm,kona-timer was kept as the 'compatible' field to make it
> specific enough for when there are multiple bcm timers (bcm,timer is
> too generic).
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: John Stultz <john.stultz@linaro.org>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Applied to my fortglx/3.10/time branch.

thanks
-john
