From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Jan 2018 11:29:53 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y
In-Reply-To: <1516037371-3932-1-git-send-email-david@lechnology.com>
References: <1516037371-3932-1-git-send-email-david@lechnology.com>
Message-ID: <800a4c95-ca8d-6235-288a-222a38c04cf9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 January 2018 10:59 PM, David Lechner wrote:
> This changes CONFIG_DAVINCI_WATCHDOG from a module to a compiled-in
> option. Since the reset function has been moved out of the mach code in
> commit 0808d3260456 ("ARM: davinci: remove watchdog reset") and into the
> watchdog driver, devices cannot reboot unless the watchdog driver is
> loaded, so make it a compiled-in option so that we can always reboot, even
> when modules are not loaded.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Hmm, we already depend on modules to load correctly for a lot of
functionality. Why should reboot be an exception? In general, unless the
driver is needed for loading rootfile system, I would keep it as a module.

Thanks,
Sekhar
