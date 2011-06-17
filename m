From: khilman@ti.com (Kevin Hilman)
Date: Fri, 17 Jun 2011 09:03:20 -0700
Subject: [PATCH] ARM: OMAP: Overo: remove illegal extra call to
	overo_ads7846_init()
In-Reply-To: <1308324110-21918-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Fri, 17 Jun 2011 17:21:50 +0200")
References: <1308324110-21918-1-git-send-email-zonque@gmail.com>
Message-ID: <87r56sbg3b.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> Signed-off-by: Daniel Mack <zonque@gmail.com>

Thanks for fixing this, I noticed this recently too.

Please add a descriptive changelog.  For example, why is it duplcate?
where is it already done?  what commit added the extra call, what
problems does it cause, etc.

Also, your subject says 'illegal', but it's not really illegal.  It's just
wrong. :)   "remove duplcate call to..." is enough.

Thanks,

Kevin


> ---
>  arch/arm/mach-omap2/board-overo.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 175e1ab..110475f 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -568,7 +568,6 @@ static void __init overo_init(void)
>  	usb_musb_init(NULL);
>  	usbhs_init(&usbhs_bdata);
>  	overo_spi_init();
> -	overo_ads7846_init();
>  	overo_init_smsc911x();
>  	overo_display_init();
>  	overo_init_led();
