From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 25 May 2011 09:40:10 +0200
Subject: [PATCH] AT91: Add VSYNC pin definition for AT91SAM9RL silicon
In-Reply-To: <1306303407-23659-1-git-send-email-hong.xu@atmel.com>
References: <1306303407-23659-1-git-send-email-hong.xu@atmel.com>
Message-ID: <20110525074010.GI863@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:03 Wed 25 May     , Hong Xu wrote:
> On Atmel's AT91SAM9RL-EK board, the LCD panel does not need VSYNC
> signal. But this signal is useful for the boards from other
> vendors, as reported by Nicholas Kinar.
> This small patch adds the VSYNC pin definition by default.
> 
> Reported-by: Nicholas Kinar <n.kinar@usask.ca>
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---
> 
>  arch/arm/mach-at91/at91sam9rl_devices.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index c49262b..87a49d9 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -538,6 +538,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
>  	}
>  
>  	at91_set_B_periph(AT91_PIN_PC1, 0);	/* LCDPWR */
> +	at91_set_A_periph(AT91_PIN_PC4, 0);	/* LCDVSYNC */
same as for 9263

this must be optionnal

Best Regards,
J.
