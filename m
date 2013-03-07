From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 7 Mar 2013 15:00:08 +0100 (CET)
Subject: [PATCH 01/10] clocksource: add generic dummy timer driver
In-Reply-To: <1362614646-24113-2-git-send-email-sboyd@codeaurora.org>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1303071457300.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Mar 2013, Stephen Boyd wrote:

> +static int __init dummy_timer_register(void)
> +{
> +	int err = register_cpu_notifier(&dummy_timer_cpu_nb);
> +	if (err)
> +		return err;
> +
> +	/* We won't get a call on the boot CPU, so register immediately */
> +	dummy_timer_setup();
> +
> +	return 0;
> +}
> +device_initcall(dummy_timer_register);

Are you sure that you want that to be installed unconditionally? What
about multi-platform kernels?

Thanks,

	tglx
