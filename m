From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 05 Oct 2010 09:35:08 -0700
Subject: [PATCH v2] OMAP2PLUS: WDT: Fix: Disable WDT after reset during
	init
In-Reply-To: <1286015771-22041-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Sat, 2 Oct 2010 16:06:11 +0530")
References: <1286015771-22041-1-git-send-email-charu@ti.com>
Message-ID: <87fwwktx6r.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Inorder to avoid any assumptions from bootloader, the watchdog
> timer module is reset during init. This enables the watchdog
> timer.
>
> Therefore, it is required to disable WDT after it is reset
> during init. Otherwise the system would reboot as per the default
> watchdog timer registers settings.
>
> Later, when the watchdog driver is loaded, the watchdog timer settings
> is adjusted as per the default timer_margin set in the driver and the
> driver would supports the normal operations supported by OMAP watchdog
> timer.
>
> Link to related discussions:
> https://patchwork.kernel.org/patch/219072/
>
> Issue reported by Kevin can be found at:
> https://patchwork.kernel.org/patch/217262/
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reported-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Tony, this should queue up for .37 on top of my pm-hwmods branch.
It applies cleanly to current l-o master.

Kevin
