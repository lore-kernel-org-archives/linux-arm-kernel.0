From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Jan 2014 10:28:50 +0800
Subject: [BUG] v3.13-rc7: freescale fec_main bugs on boot
In-Reply-To: <20140105170448.GC27432@n2100.arm.linux.org.uk>
References: <20140105170448.GC27432@n2100.arm.linux.org.uk>
Message-ID: <20140106022847.GB26128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 05:04:48PM +0000, Russell King - ARM Linux wrote:
> Second thing is this which was introduced by 7a399e3a2e05 between rc6
> and rc7:
> 
> +       if (flags & OF_GPIO_ACTIVE_LOW)
> +               port = GPIOF_OUT_INIT_LOW;
> +       else
> +               port = GPIOF_OUT_INIT_HIGH;
> 
> -       gpio_set_value(phy_reset, 1);
> +       gpio_set_value(phy_reset, !port);

Fabio just sent a patch to revert it, and David has queued it.  Sorry
for that I did not catch it.

Shawn
