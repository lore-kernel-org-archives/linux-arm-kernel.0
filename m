From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Dec 2011 11:03:38 +0100
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <20111207090734.GN27267@pengutronix.de>
References: <201106301441.24493.arnd@arndb.de> <4E11994B.7070103@gmail.com>
 <20110704124318.GI6069@pengutronix.de>
 <201107041607.10265.arnd@arndb.de>
 <20111207085339.GA7970@avionic-0098.mockup.avionic-design.de>
 <20111207090734.GN27267@pengutronix.de>
Message-ID: <20111214100338.GA18348@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sascha Hauer wrote:
> I have a branch which adds a basic PWM framework. It doesn't change the
> pwm API at all, but only adds support for registering multiple PWM
> drivers. All in Kernel drivers are converted to this new framework, but
> except the i.MX driver all of them are untested. I'm quite confident
> that the drivers itself work, but there will probably be some Kconfig
> related issues which I wasn't able to sort out. The corresponding
> Maintainers should probably have a look over it. Feel free to post
> the patches if you are prepared to work on the comments you receive.
> Otherwise I'll see if I find some time maybe next week.
[...]

I've looked at this in more detail and one thing that irritates me is that
the current driver API requires a driver to register a pwm_chip structure for
each PWM it can control. Wouldn't it be easier in such cases to just specify
how many PWMs a chip wants to register, much like gpiolib does it?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111214/dcaef88c/attachment.sig>
