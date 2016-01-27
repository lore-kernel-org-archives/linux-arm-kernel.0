From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 27 Jan 2016 15:43:03 -0800
Subject: [PATCH] input: xpad: remove unused function
In-Reply-To: <1453735884-1958624-1-git-send-email-arnd@arndb.de>
References: <1453735884-1958624-1-git-send-email-arnd@arndb.de>
Message-ID: <20160127234303.GG28687@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 04:30:41PM +0100, Arnd Bergmann wrote:
> There are two definitions of xpad_identify_controller(), one is used
> when CONFIG_JOYSTICK_XPAD_LEDS is set, but the other one is empty
> and never used, and we get a gcc warning about it:
> 
> drivers/input/joystick/xpad.c:1210:13: warning: 'xpad_identify_controller' defined but not used [-Wunused-function]
> 
> This removes the second definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cae705baa40b ("Input: xpad - re-send LED command on present event")

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 6727954ab74b..e8a84d12b7ff 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1207,7 +1207,6 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
>  #else
>  static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
>  static void xpad_led_disconnect(struct usb_xpad *xpad) { }
> -static void xpad_identify_controller(struct usb_xpad *xpad) { }
>  #endif
>  
>  static int xpad_start_input(struct usb_xpad *xpad)
> -- 
> 2.7.0
> 

-- 
Dmitry
