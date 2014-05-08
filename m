From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 May 2014 21:55:56 +0100
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <CAD=FV=X4h0nfO7a10NXe+d76xj5ttBJx=q1pAvW4aPzrc22BoQ@mail.gmail.com>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <CAD=FV=X4h0nfO7a10NXe+d76xj5ttBJx=q1pAvW4aPzrc22BoQ@mail.gmail.com>
Message-ID: <20140508205556.GJ3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 11:06:24AM -0700, Doug Anderson wrote:
> I guess I would say that my patch is unhacking the this code.  The
> code after my patch is simpler.  I would perhaps argue that (ec971ea
> ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp)
> should never have landed to begin with.

That depends on your point of view.  As I've already pointed out through
the examples of why udelay() is inaccurate, for driver authors, they
should assume that udelay() just gives you an "approximate" delay and
it has no accuracy.

When you start from that point, rather than (as you seem to be) believing
that it has some kind of accuracy, then the implementation of scaling the
loops_per_jiffy is entirely reasonable - it's a best effort implementation.

Again, just use a timer for your udelay() implementation.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
