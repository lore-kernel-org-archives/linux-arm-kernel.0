From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 19 Nov 2012 10:27:18 -0600
Subject: [PATCH v2 1/2] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
References: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <50AA5DE6.4080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/18/2012 09:06 AM, Igor Grinberg wrote:
> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
> setting.
> To remove the dependancy, several conversions/additions had to be done:
> 1) Timer initialization functions are named by the platform
>    name and the clock source in use.
>    This also makes it possible to define and use the GPTIMER as the
>    clock source instead of the 32K timer on platforms that do not have
>    the 32K timer ip block or the 32K timer is not wired on the board.
>    Cirrently, the the timer is chosen in the machine_desc structure on

Nit ...

s/Cirrently/Currently

Otherwise ...

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks for updating this!

Cheers
Jon
