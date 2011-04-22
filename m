From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Apr 2011 13:36:44 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTinrtoGhL3CXJZGWzf8+BwFSRsdk0w@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinrtoGhL3CXJZGWzf8+BwFSRsdk0w@mail.gmail.com>
Message-ID: <BANLkTikDCmH-WX1u3e9c7gc2U9HJ88RBUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/21 Stijn Devriendt <highguy@gmail.com>:

> There's a couple of things I added on top of what you already seem to have:
> - in include/linux/of_gpio.h the of_gpio_flags were extended to
> support open-drain in device-trees.

Device tree support can very well be handled as an add-on I believe,
please feel free to do that on top of my patch set :-)

> - the debugfs support in gpiolib was also updated to export the current state to
> ?the user through sysfs.

Hm, I've rewritten the mechanism (see latest patch set) to just take
anonymous parameter and argument. This means it's hard to do
this in any generic manner, and debugfs printing och config parameters
need to be pushed to each driver.

> I'd also like to add (if not already mentioned by others) that in
> general drivers that use GPIOs are unaware of their physical
> connection on the board. Having this information
> in device-tree or platform-data equivalent solves this.

Yes, this has been mentioned a few times, and a few times I have
replied that there is not one word in the patch set that says anything
about whether drivers or board code or whatever shall make use of
the mechanism, it's just an interface...

I don't understand why this keeps popping up, have I written
*anything* unclear about this?

> Secondly I tend to disagree with the "silently ignored" case when the
> underlying driver
> does not support setting drive mode. You can easily break the chip if
> setting the drive
> mode fails (although the HW designers may have selected the faulty
> chip then ;) ).

In the latest version the config operation returns an error code.

Yours,
Linus Walleij
