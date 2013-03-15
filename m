From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 16:07:09 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <1363362247-9542-1-git-send-email-arnd@arndb.de>
References: <1363362247-9542-1-git-send-email-arnd@arndb.de>
Message-ID: <201303151607.09677.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Arnd Bergmann wrote:
> @@ -1409,10 +1409,20 @@ static int __init ehci_hcd_init(void)
>         if (retval < 0)
>                 goto clean4;
>  #endif
> +
> +#ifdef OMAP_PLATFORM_DRIVER
> +       retval = platform_driver_register(&OMAP_PLATFORM_DRIVER);
> +       if (retval < 0)
> +               goto clean5;
> +#endif

There was a missing hunk for the ORION part like the one above since
I unfortunately had done this patch on the wrong base.  I will resubmit
a proper patch if we get an agreement on the approach taken.

	Arnd
