From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Sep 2015 13:56:08 +0100
Subject: [RFC 5/5] HACK: serial: move pl011 initcall to device_initcall
In-Reply-To: <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150908125608.GD20562@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 01:43:37PM +0100, Leif Lindholm wrote:
> ---
>  drivers/tty/serial/amba-pl011.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 452dbba..31cf985 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2806,7 +2806,7 @@ static void __exit pl011_exit(void)
>   * While this can be a module, if builtin it's most likely the console
>   * So let's leave module_exit but move module_init to an earlier place
>   */
> -arch_initcall(pl011_init);
> +device_initcall(pl011_init);
>  module_exit(pl011_exit);

What's the ordering constraint that you're trying to solve with this?

The cover didn't mention anything, and there's no commit message.

Mark.

>  
>  MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
> -- 
> 2.1.4
> 
