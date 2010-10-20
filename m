From: simon@sequanux.org (Simon Guinot)
Date: Wed, 20 Oct 2010 00:19:13 +0000
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <1287525825.9690.313.camel@groeck-laptop>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287525825.9690.313.camel@groeck-laptop>
Message-ID: <20101020001913.GI29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Tue, Oct 19, 2010 at 03:03:45PM -0700, Guenter Roeck wrote:
> Hi Simon,
> 
> one more comment ...
> 
> On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> [ ... ]
> > +static int __devinit
> > +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *alarm)
> > +{
> 
> __devinit and __devexit can cause problems if this driver is built into
> the kernel, but the underlying i2c master driver is built as module.

I am not sure I understand this. Are you talking about a I2C GPIO
expander ? or about the hwmon registration process ?

For the first case, no I2C mean no GPIOs and the gpio-fan initialization
will fail (because no GPIO chip available). There is nothing wrong with
freeing the useless init functions.

For the second case, let me know...

Not really related, but there is too much __devinit and __devexit
declarations in the first patch version. Thanks to the compiler, all
this functions are inlined in the good place.

> 
> So please remove __devinit and __devexit.

I will if you tell me why :)

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101020/f0e121e2/attachment.sig>
