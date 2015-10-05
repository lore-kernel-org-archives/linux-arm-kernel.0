From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Oct 2015 03:50:34 -0700
Subject: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <560DACD8.8000301@linaro.org>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
 <560DACD8.8000301@linaro.org>
Message-ID: <20151005105034.GU23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [151001 15:04]:
> >+	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> >+			32768, NSEC_PER_SEC, 120000);
> >+
> >+	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
> >+				250, 32, clocksource_mmio_readl_up);
> >+	if (ret) {
> >+		pr_err("32k_counter: can't register clocksource\n");
> >+		return;
> >+	}
> >+
> >+	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
> >+	register_persistent_clock(NULL, omap_read_persistent_clock64);
> 
> I will let John Stultz to have a look at this part because I have doubt
> regarding the usage of the persistent clock.

The persistent clock we want to keep for deeper idle states..
Especially when we start changing clocksource for the duration of
deeper idle states. I'll post some updated patches on that when I
get a chance.

Regards,

Tony
