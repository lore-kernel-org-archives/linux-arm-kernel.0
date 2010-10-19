From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Tue, 19 Oct 2010 15:03:45 -0700
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <1287330612-11256-1-git-send-email-simon@sequanux.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
Message-ID: <1287525825.9690.313.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

one more comment ...

On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
[ ... ]
> +static int __devinit
> +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *alarm)
> +{

__devinit and __devexit can cause problems if this driver is built into
the kernel, but the underlying i2c master driver is built as module.

So please remove __devinit and __devexit.

Thanks,
Guenter
