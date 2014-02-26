From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Feb 2014 14:25:30 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <CACRpkdb1T1GCqEpy9=fPp4hYQErLYiQqJezrFhoS3x1MU=0S9g@mail.gmail.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <20140210104032.GB20143@ulmo.nvidia.com>
 <CACRpkdb1T1GCqEpy9=fPp4hYQErLYiQqJezrFhoS3x1MU=0S9g@mail.gmail.com>
Message-ID: <20140226132529.GC29779@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 12:09:29PM +0100, Linus Walleij wrote:
> On Mon, Feb 10, 2014 at 11:40 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> 
> > it seems like at least BACKLIGHT_LP8788 is missing a corresponding
> > dependency as well.
> >
> > I have applied Sascha's patch to remove the obsolete HAVE_PWM symbol,
> > and this will fix at least the build issues. However it will also cause
> > the driver to fail at runtime because the pwm_*() functions won't work.
> 
> So it definately needs that API, not just stubs.
> 
> But isn't it proper for Kconfig to allow you to break things
> like that by configuring out stuff and have stubs come in?
> 
> I'm a bit torn here.

After thinking about this some more, I've come to the conclusion that
the drivers should have the dependency. Kconfig should make sure that
the resulting drivers work.

If somebody wanted to knowingly build this driver with a configuration
that won't work at runtime, then they should be using COMPILE_TEST
instead.

So I'm leaning towards applying this patch if there are no objections.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/a392f056/attachment.sig>
