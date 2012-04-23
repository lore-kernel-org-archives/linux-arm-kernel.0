From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 23 Apr 2012 14:01:10 +0200
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <20120423115140.GA15792@lunn.ch> (Andrew Lunn's message of "Mon,
 23 Apr 2012 13:51:40 +0200")
References: <20120423115140.GA15792@lunn.ch>
Message-ID: <87bomiy7w9.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

>> One way to solve it would be to add a blink function to gpiolib so
>> that the gpio-led driver can access it through a common wrapper
>> and we can make the orion_gpio_set_blink() function a pointer in
>> the gpio_chip structure rather than an export from
>> arch/arm/plat-orion/gpio.c. I've put a few people on Cc that might
>> have an opion on this.
>
> Hi Arnd
>
> That would work for Orion based devices. However, take a look at
> mach-s3c24xx. It has two different blink_set functions, one in
> mach-s3c24xx/mach-h1940.c and another in mach-s3c24xx/mach-rx1950.c.

[ for the record, it happens that I worked on the h1940 support but it's
been quite some time I didn't boot it ]

>
> So the blink_set function probably needs to be board specific in some
> cases.

imho the kirkwood/orion/... case is an exception rather than the
rule. Moreover, nothing prevents a HW designer to use something else to
handle hw blinking instead of the kirkwood blinking method. After all,
this method has a fixed frequency of 2^24 tclk (which makes it 100ms on
most boards).

Arnaud
