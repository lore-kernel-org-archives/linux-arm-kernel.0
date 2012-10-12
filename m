From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Oct 2012 13:40:58 +0900
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20121012044042.GI11726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 10:34:18AM +0800, Bo Shen wrote:
> As the old method will use platform device id, change the id to
> let the i2c device work

What are "the old method" and new method?  You're not explaining why
this is needed...

>  static struct platform_device at91sam9260_twi_device = {
>  	.name			= "i2c-gpio",
> -	.id			= -1,
> +	.id			= 0,
>  	.dev.platform_data	= &pdata,

This looks like a regression, if there's only one of a given type of
device in the system it should have no numeric ID in the display name so
having -1 is appropriate.
