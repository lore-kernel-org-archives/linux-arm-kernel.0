From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Oct 2018 18:45:43 +0200
Subject: [PATCH] ASoC: sun4i-i2s: don't try to start up or shut down DAI
 if it's active
In-Reply-To: <7437935.iAfLsdZGOz@anarsoul-thinkpad>
References: <20181012153254.10844-1-anarsoul@gmail.com>
 <20181012160905.GA2340@sirena.org.uk>
 <7437935.iAfLsdZGOz@anarsoul-thinkpad>
Message-ID: <20181012164543.GF2340@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 09:28:56AM -0700, Vasily Khoruzhick wrote:
> On Friday, October 12, 2018 9:09:05 AM PDT Mark Brown wrote:
> > On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> > > Otherwise we may end up with shutting down I2S if shutdown() was
> > > called for capture substream, but playback is still running.

> > Would it be cleaner and more robust to use runtime PM?  I'm wondering
> > what happens if some of the configuration stuff turns out to also need
> > some of the clocks for example.

> I guess. I'm not sure why this code was put into startup and shutdown 
> callbacks in first place.

> Maybe Marcus or Maxime know?

> As for configuration - only bus clock is necessary for configuration and it's 
> already enabled in runtime_resume() callback.

Probably these really are only needed when audio is active so it's
saving that little bit of power in which case your fix looks good to me
but I'll leave a chance for the people with system specific knowledge to
review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/18d50e17/attachment.sig>
