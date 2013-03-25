From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 08:50:22 -0500
Subject: [PATCH 03/10] clocksource: sunxi: make use of CLKSRC_OF
In-Reply-To: <1364218233-29636-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364218233-29636-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5150561E.2070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 08:30 AM, Maxime Ripard wrote:
> Using CLKSRC_OF allows to remove the SoC specific sunxi_timer.h header,
> and instead of using a custom init function in the machine definition
> use the standard clocksource_of_init function.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

[...]

> @@ -158,3 +157,5 @@ void __init sunxi_timer_init(void)
>  	clockevents_config_and_register(&sunxi_clockevent, rate / TIMER_SCAL,
>  					0x1, 0xff);
>  }
> +CLOCKSOURCE_OF_DECLARE(sunxi, "allwinner,sun4i-timer",
> +		       sunxi_timer_init);

You should base this on clocksource clean-up branch "clksrc/cleanup" in
arm-soc. That will get rid of double matching and match table.

Also, sunxi_timer_init can be static now.

Rob
