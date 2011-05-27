From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 10:48:00 +0200
Subject: [PATCH 2/3] ARM: mxs: add gpio-mxs platform devices
In-Reply-To: <20110527082916.GB30146@S2100-06.ap.freescale.net>
References: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
	<201105201223.00427.arnd@arndb.de>
	<20110527082916.GB30146@S2100-06.ap.freescale.net>
Message-ID: <201105271048.00692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011, Shawn Guo wrote:

> > I know it's tempting to use macros for these, but I think it obscures
> > the code a lot, especially when you use them to concatenate identifier
> > names. Why not just do:
> > 
> >       struct platform_device *gpios;
> >       gpios = platform_device_register_simple(mxs_host_bus, "mxs-gpio-master", 0, NULL, 0);
> > 
> platform_device_register_simple does not have parameter for 'parent',
> and it sets 'parent' NULL anyway.
> 

Oops, my mistake. just use platform_device_register_resndata directly then.

	Arnd
