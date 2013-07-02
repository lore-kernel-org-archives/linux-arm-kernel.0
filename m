From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 01 Jul 2013 17:18:54 -0700
Subject: [PATCH 0/4] rtc: omap: handle rtc wakeup support in driver
In-Reply-To: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 28 Jun 2013 15:05:05 +0530")
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87sizxn79t.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hebbar,

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> rtc-omap driver modules is used both by OMAP1/2, Davinci SoC platforms.
>
> However, rtc wake support on OMAP1 is broken. Hence the
> device_init_wakeup() was removed from rtc-omap driver and moved to
> platform board files that supported it (DA850/OMAP-L138). [1]
>
> However, recently [2] it was suggested that driver should always do a
> device_init_wakeup(dev, true). Platforms that don't want/need
> wakeup support can disable it from userspace via:
>
>     echo disabled > /sys/devices/.../power/wakeup
>
> Also, with the new DT boot-up, board file doesn't exist and hence there
> is no way to have device wakeup support rtc.
>
> The fix for above issues, is to hard code device_init_wakeup() inside
> driver and let platforms that don't need this, handle it through the
> sysfs power entry.

This series looks good now, thanks for your persistence.

Kevin
