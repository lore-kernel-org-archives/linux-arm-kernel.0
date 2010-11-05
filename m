From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 05 Nov 2010 11:48:09 +0100
Subject: [PATCH 2/2] backlight: Fix blanking for L4F00242T03 LCD
In-Reply-To: <1275731441-7612-2-git-send-email-marek.vasut@gmail.com>
References: <1275731441-7612-1-git-send-email-marek.vasut@gmail.com>
	<1275731441-7612-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <1288954089.3072.10.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sab, 2010-06-05 at 11:50 +0200, Marek Vasut wrote:
> The LCD was turned on if the variable power was > 0, but that was incorrect. The
> LCD has to be turned on in NORMAL and UNBLANK case.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Richard,
Are you still maintaining the backlight tree?
These two patches never hit the mainline since gen, I hope this will 
happen soon since they really fix bugs :)

Best Regards,
Alberto!

Oh, add also this tag if possible:

Acked-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
 
> ---
>  drivers/video/backlight/l4f00242t03.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> index 9093ef0..c67801e 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -78,7 +78,7 @@ static int l4f00242t03_lcd_power_set(struct lcd_device *ld, int power)
>  	const u16 slpin = 0x10;
>  	const u16 disoff = 0x28;
>  
> -	if (power) {
> +	if (power <= FB_BLANK_NORMAL) {
>  		if (priv->lcd_on)
>  			return 0;
>  


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
