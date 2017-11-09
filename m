From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 08 Nov 2017 16:50:55 -0800
Subject: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: fix power-off when
 powered by bootloader
In-Reply-To: <1509723804-21114-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 3 Nov 2017 16:43:24 +0100")
References: <1509723804-21114-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hshdoi8b4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Neil Armstrong <narmstrong@baylibre.com> writes:

> In the case the VPU power domain has been powered on by the bootloader
> and no driver are attached to this power domain, the genpd will power it
> off after a certain amount of time, but the clocks hasn't been enabled
> by the kernel itself and the power-off will trigger some faults.
> This patch enable the clocks to have a coherent state for an eventual
> poweroff and switches to the pm_domain_always_on_gov governor.
>
> Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

This fixes a patch that's currently in arm-soc next/drivers (or
amlogic/drivers-2 to be precise.)

If it's not too late, please feel free to apply directly.  If not, I
will queue up for v4.15-rc fixes cycle.

Thanks,

Kevin
