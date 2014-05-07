From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 13:01:07 +0200
Subject: [RFC PATCH 0/5] watchdog: Add reboot API
In-Reply-To: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
Message-ID: <1510930.uYSL31jzkj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. Mai 2014, 08:41:28 schrieb Guenter Roeck:
> Some hardware implements reboot through its watchdog hardware, for example
> by triggering a watchdog timeout or by writing into its watchdog register
> set. Platform specific code starts to spread into watchdog drivers,
> typically by setting pointers to a callback function which is then called
> from the architecture's reset handler.
> 
> While global and exported callback function pointers (such as
> arm_pm_restart) may be acceptable as long as they are used from platform
> and/or architecture code, using such a mechanism across subsystems and
> drivers is less than desirable. Ultimately, we'll need a better solution.
> 
> This patch series is an attempt to provide such a solution. It extends
> the watchdog subsystem to support reboot functionality, provides an
> API function call to trigger reboots, adds support for the new API
> to arm and arm64, and converts the drivers providing reboot functionality
> to use the new infrastructure.
> 
> The first patch in the series implements the new API. The second and third
> patch modify the arm and arm64 architecture reset handlers to call the
> added API function. The final two patches register the reboot handlers
> in the sunxi and moxart watchdog drivers with the watchdog subsystem.
> 
> The sunxi patche depends on the most recent patch series sumitted by
> Maxime Ripard.

a lot of Samsung architectures use a watchdog based reset too (among them some 
of the s3c24xx I care about) and this series looks really great for this, so

Acked-by: Heiko Stuebner <heiko@sntech.de>
