From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 26 May 2015 10:45:02 -0700
Subject: [PATCH v4 04/18] input: locomokbd: differentiate between two
 Enter keys
In-Reply-To: <1432554113-26280-5-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
 <1432554113-26280-5-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150526174502.GB10571@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 02:41:39PM +0300, Dmitry Eremin-Solenikov wrote:
> There are two Enter keys on collie/poodle keyboards. Make one of them to
> generate KEY_KPENTER rather than just KEY_ENTER.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/locomokbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> index 9742c79..7645053 100644
> --- a/drivers/input/keyboard/locomokbd.c
> +++ b/drivers/input/keyboard/locomokbd.c
> @@ -50,7 +50,7 @@ locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
>  	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
>  	KEY_UP, KEY_LEFT, 0, 0, KEY_P, 0, KEY_O, KEY_I, KEY_Y, KEY_T,		/* 50 - 59 */
> -	KEY_E, KEY_W, 0, 0, 0, 0, KEY_DOWN, KEY_ENTER, 0, 0,			/* 60 - 69 */
> +	KEY_E, KEY_W, 0, 0, 0, 0, KEY_DOWN, KEY_KPENTER, 0, 0,			/* 60 - 69 */
>  	KEY_BACKSPACE, 0, KEY_L, KEY_U, KEY_H, KEY_R, KEY_D, KEY_Q, 0, 0,	/* 70 - 79 */
>  	0, 0, 0, 0, 0, 0, KEY_ENTER, KEY_RIGHTSHIFT, KEY_K, KEY_J,		/* 80 - 89 */
>  	KEY_G, KEY_F, KEY_X, KEY_S, 0, 0, 0, 0, 0, 0,				/* 90 - 99 */
> -- 
> 2.1.4
> 

-- 
Dmitry
