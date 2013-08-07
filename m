From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 7 Aug 2013 12:35:42 -0700
Subject: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
In-Reply-To: <1374623475.SoL01ZHzWk@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
 <1478465.17AL5GbAI8@flatron> <1374623475.SoL01ZHzWk@flatron>
Message-ID: <CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

> +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> +/*
> + * PWM block is shared between pwm-samsung and samsung_pwm_timer drivers
> + * and some registers need access synchronization. If both drivers are
> + * compiled in, the spinlock is defined in the clocksource driver,
> + * otherwise following definition is used.
> + *
> + * Currently we do not need any more complex synchronization method
> + * because all the supported SoCs contain only one instance of the PWM
> + * IP. Should this change, both drivers will need to be modified to
> + * properly synchronize accesses to particular instances.
> + */
> +static DEFINE_SPINLOCK(samsung_pwm_lock);

Shouldn't this not be static?  It's declared in
clocksource/samsung_pwm.h whether or not the samsung_pwm_timer is
compiled in or not.

Thanks,
Andrew
