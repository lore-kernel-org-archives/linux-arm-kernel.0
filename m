From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 09:40:57 +0200
Subject: [PATCH v3] clocksource: arch_timer: Allow the device tree to
 specify uninitialized CNTVOFF
In-Reply-To: <1412663852-32681-1-git-send-email-sonnyrao@chromium.org>
References: <1412663852-32681-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <2943095.1HCacZ7zIg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 23:37:32 Sonny Rao wrote:
> 
> +#ifdef CONFIG_ARM
> +       /*
> +        * If we cannot rely on firmware initializing the CNTVOFF then
> +        * we should use the physical timers instead.
> +        */
> +       if (of_property_read_bool(np, "arm,cntvoff-not-fw-configured"))
> +               arch_timer_use_virtual = false;
> +#endif
> +
> 

Sorry for the nitpicking, but can this please use

	if (IS_ENABLED(CONFIG_ARM))

to avoid the ugly #ifdef?

	Arnd
