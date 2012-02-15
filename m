From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Feb 2012 14:14:08 -0800
Subject: [PATCH] ARM: OMAP: convert omap_device_build() and callers to
 __init
In-Reply-To: <1329343522-15759-1-git-send-email-khilman@ti.com>
References: <1329343522-15759-1-git-send-email-khilman@ti.com>
Message-ID: <20120215221408.GZ1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120215 13:33]:
> Building omap_devices should only be done at init time, and since
> omap_device_build() is using early_platform calls which are also
> __init, this ensures that omap_device isn't trying to use functions
> that disappear.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, I tested this on top of your MMC series, and it gets rid of the
> rest of the section mismatch warnings except the
> omap_secondary_startup() one which is unrelated to this patch.

OK thanks, I'll apply them all with your patch into hsmmc branch once
they're done because this depends on the hsmmc changes.

Regards,

Tony
