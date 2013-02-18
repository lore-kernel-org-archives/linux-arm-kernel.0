From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 18 Feb 2013 15:34:56 +0530
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5121FCC8.7090604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling.
>
> The series tries to address the issue
>
> Patches has been tested on OMAP4 and OMAP5 devices where the console
> slugishness was observed without idle mode handling. CPUIDLE and
> suspend tested ok on these devices.
>
> Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
>
> Santosh Shilimkar (2):
>    ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
>      modes
>    SERIAL: OMAP: Remove the idle handling from the driver
>
HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
Also considering UART also needs async wakeup enabled as it implements
another such hook and attaches that through function pointer.

So some more work is needed to get that sorted out at least from
sysc point of view. That way we can deal with io_ring stuff using
pin control APIs.

Some patches will follow in attempt to address it. Stay tuned !!

Regards,
Santosh
