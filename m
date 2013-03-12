From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 18:51:35 +0000
Subject: [PATCH v2 02/14] clocksource: sp804: add device tree support
In-Reply-To: <1363108124-17484-3-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121851.35326.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> +static void __init sp804_dt_init(void)
> +{
...
> +
> +       np = of_find_matching_node(from, sp804_timer_match);
...
> +}
> +CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_dt_init);

On second thought, I guess it would be nice if we could change the
calling conventions for CLOCKSOURCE_OF_DECLARE init functions to
always pass the device along.  It is a bit silly if we already have
the node in clocksource_of_init and then require the init function
to call of_find_matching_node(). That change would also make patch
3 in this series unnecessary.

	Arnd
