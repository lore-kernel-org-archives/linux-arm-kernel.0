From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 28 May 2013 00:58:09 -0700
Subject: [PATCH v2] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
In-Reply-To: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
References: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130528075808.GA19496@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Tue, May 28, 2013 at 10:47:38AM +0800, Barry Song wrote:
> +	/*
> +	 * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
> +	 * to queue a SUSPEND APM event
> +	 */
> +	input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
> +	input_sync(pwrcdrv->input);
> +
> +	/*
> +	 * Todo: report KEY_POWER event for Android platforms, Android PowerManager
> +	 * will handle the suspend and powerdown/hibernation
> +	 */
> +
...

> +
> +	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
> +	set_bit(KEY_POWER, pwrcdrv->input->keybit);

Why are we setting up KEY_POWER if we do not send this event?

Thanks.

-- 
Dmitry
