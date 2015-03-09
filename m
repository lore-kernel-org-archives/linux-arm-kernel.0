From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 09 Mar 2015 13:43:57 -0700
Subject: [RFC] Mediatek SCPSYS power domain support
In-Reply-To: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Mon, 9 Mar 2015 09:09:59 +0100")
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hoao16gvm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> s series adds support for the MediaTek SCPSYS unit.
>
> The SCPSYS unit handles several power management related tasks such
> as thermal measurement, DVFS, interrupt filter and low level sleep
> control.
>
> The initial support only contains the generic power domain handling.
> This is needed to turn on power to the different power domains.
>
> The driver is quite straight forward now. Due to the lack of a better
> place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
> several other tasks that also do not fit into some specific subsystem
> this probably is a good place for this driver.
>
> What is not clear to me is how the Kconfig dependencies should be
> handled. Some domains are disabled by bootloader default, so without
> this driver for example sound won't work. So should PM, PM_GENERIC_DOMAINS
> and this driver be made mandatory for MT8173? Or should this driver
> when PM is disabled be compiled as a stub which only enables all
> domains? I don't have a good idea how things should work out here.

IMO, a stub that enables all the domains is what you want.

Kevin
