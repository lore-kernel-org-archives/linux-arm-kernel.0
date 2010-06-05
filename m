From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 05 Jun 2010 11:25:24 +0200
Subject: [PATCH 2/2] backlight: Fix blanking for L4F00242T03 LCD
In-Reply-To: <1275701106-2832-2-git-send-email-marek.vasut@gmail.com>
References: <1275701106-2832-1-git-send-email-marek.vasut@gmail.com>
	<1275701106-2832-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275729924.3446.13.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sab, 2010-06-05 at 03:25 +0200, Marek Vasut wrote:
> The LCD was turned on if the variable power was > 0, but that was incorrect. The
> LCD has to be turned on in every case but POWERDOWN.

The patch is ok for me, but the comment could much more reflect what
the patch does, no?

> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
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
