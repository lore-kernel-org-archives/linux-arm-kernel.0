From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 May 2013 09:54:56 +0800
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <20130525201032.GD32043@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
Message-ID: <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/26 Mark Brown <broonie@kernel.org>:
> On Thu, May 16, 2013 at 06:25:39PM +0800, Barry Song wrote:
>> 2013/5/16 Wolfram Sang <wsa@the-dreams.de>:
>
>> > What about deferred probing?
>
>> deferred probing could work but could not work for automative.
>> what we really want is that devices begin to work as early as
>> possible. we want i2c clients like lcd, camera begin to show images as
>> early as possible as an automative requirement.
>
> Probe deferral should have at most a mimimal impact on the boot time -
> it's pretty much just changing the order providing the probe functions
> aren't excessively slow to defer.  If the probe functions are taking a
> long time to defer that's probably what needs looking at.
>
> If it really is probe deferral itself that's too slow then we ought to
> be looking at improving that rather than boding around it.

Mark, the case is not that deferred probing is slow or not. deferred
probing is pretty good.
the case is that we want to i2c and media connected with i2c probed
earlier than other devices.
in auto infotainment devices, we actually do some hacking in kernel
that makes rear view work earlier than other device driver
initialization with a kernel thread which take care of backing-car
policy not only mechanism. that means, we make camera work to see
backview image even earlier than other drivers' initialization.
we don't want media deferred to wait for i2c. we want make some early
jobs ready earlier.

-barry
