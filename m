From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 6 Nov 2014 13:50:32 +0200
Subject: [PATCH] leds: leds-gpio: Fix legacy GPIO number case
In-Reply-To: <1415273003-27674-1-git-send-email-geert+renesas@glider.be>
References: <1415273003-27674-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141106115032.GN1618@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:23:23PM +0100, Geert Uytterhoeven wrote:
> In the legacy case, led_dat->gpiod is initialized correctly, but
> overwritten later by template->gpiod, which is NULL, causing leds-gpio
> to fail with:
> 
>     gpiod_direction_output: invalid GPIO
>     leds-gpio: probe of leds-gpio failed with error -22
> 
> Move the initialization of led_dat->gpiod from template->gpiod up, and
> always use led_dat->gpiod later, to fix this.
> 
> Fixes: 5c51277a9ababfa4 ("leds: leds-gpio: Add support for GPIO descriptors")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
