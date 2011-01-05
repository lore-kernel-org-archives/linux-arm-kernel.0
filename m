From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 5 Jan 2011 09:08:13 +0200
Subject: [PATCH] leds/h1940: Use gpiolib for latch access / fix build
	failure
In-Reply-To: <20110104153725.2f3fede2.akpm@linux-foundation.org>
References: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
	<201012100016.58130.anarsoul@gmail.com>
	<20110104153725.2f3fede2.akpm@linux-foundation.org>
Message-ID: <201101050908.14661.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 January 2011 01:37:25 Andrew Morton wrote:
> On Fri, 10 Dec 2010 00:16:57 +0200
> 
> Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > On Friday 10 December 2010 00:04:52 Peter Huewe wrote:
> > > This patch fixes a build failure by converting leds-h1940.c to use
> > > gpiolib for latch access introduced by 14477095abc6
> > > (ARM: h1940: Use gpiolib for latch access)
> > > 
> > > Unfortunately this driver was not converted back then.
> > 
> > I sent similar patch (however, my patch does gpio_request/gpio_free)
> > ~month ago.
> > 
> > Here's link:
> > http://www.spinics.net/lists/arm-kernel/msg103429.html
> 
> So which patch to use?
> 
> I queued Peter's patch because it's simpler.  I queued it for
> 2.6.38-rc1, taged for backporting into 2.6.37.x, so we have a bit of
> time to think about it.

It's simplier, but it does not request gpio before use. It will work, but will 
print nasty warning.

Regards,
Vasily
