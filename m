From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 6 Sep 2016 16:36:25 +0200 (CEST)
Subject: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
In-Reply-To: <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org>
 <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
Message-ID: <alpine.DEB.2.20.1609061635000.5647@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016, fu.wei at linaro.org wrote:
> +	if (timer_count < 0)
> +		pr_err("Failed to get platform timer info, skipping.\n");

So this prints something about skipping. But then it continues as if
nothing went wrong. That's either wrong or confusing or both.

> -	arch_timer_init();
> -	return 0;
> +	return arch_timer_init();

Thanks,

	tglx
