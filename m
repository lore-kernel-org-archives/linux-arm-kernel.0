From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 31 May 2011 10:28:00 +0200
Subject: [PATCH 1/1] AT91: flexibity: default leds to heartbeat
In-Reply-To: <1306775627-6640-1-git-send-email-maxim.osipov@gmail.com>
References: <1306775627-6640-1-git-send-email-maxim.osipov@gmail.com>
Message-ID: <20110531082800.GE26294@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:13 Mon 30 May     , Maxim Osipov wrote:
> This patch changes default behavior of Flexibity board LEDs to blinking
> for boot diagnostic purpose.
> 
> Signed-off-by: Maxim Osipov <maxim.osipov@gmail.com>
> ---
>  arch/arm/mach-at91/board-flexibity.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
> index 4fdc96c..8cbec8a 100644
> --- a/arch/arm/mach-at91/board-flexibity.c
> +++ b/arch/arm/mach-at91/board-flexibity.c
> @@ -96,49 +96,49 @@ static struct gpio_led flexibity_leds[] = {
>  		.name			= "usb1:green",
>  		.gpio			= AT91_PIN_PA12,
>  		.active_low		= 1,
> -		.default_trigger	= "default-on",
> +		.default_trigger	= "heartbeat",
can we factorize this a few
they have all the same default_trigger and active low

Best Regards,
J.
