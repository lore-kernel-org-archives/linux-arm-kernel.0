From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 12 Oct 2018 09:28:56 -0700
Subject: [PATCH] ASoC: sun4i-i2s: don't try to start up or shut down DAI
 if it's active
In-Reply-To: <20181012160905.GA2340@sirena.org.uk>
References: <20181012153254.10844-1-anarsoul@gmail.com>
 <20181012160905.GA2340@sirena.org.uk>
Message-ID: <7437935.iAfLsdZGOz@anarsoul-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 12, 2018 9:09:05 AM PDT Mark Brown wrote:
> On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> > Otherwise we may end up with shutting down I2S if shutdown() was
> > called for capture substream, but playback is still running.
> 
> Would it be cleaner and more robust to use runtime PM?  I'm wondering
> what happens if some of the configuration stuff turns out to also need
> some of the clocks for example.

I guess. I'm not sure why this code was put into startup and shutdown 
callbacks in first place.

Maybe Marcus or Maxime know?

As for configuration - only bus clock is necessary for configuration and it's 
already enabled in runtime_resume() callback.
