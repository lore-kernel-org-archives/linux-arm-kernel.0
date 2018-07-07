From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 7 Jul 2018 17:59:21 +0200
Subject: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
References: <20180627220656.19298-1-javierm@redhat.com>
Message-ID: <20180707155921.GA26504@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.
> 
> Since drivers and devices are registered in a non-deterministic way, it is
> possible that a device that is a dependency has not been registered yet by
> the time that is looked up.
> 
> In this case the driver that requires this dependency cannot probe and has
> to defer it. So the driver core adds it to a list of deferred devices that
> is iterated again every time that a new driver is probed successfully.
> 
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
> 
>   $ cat /sys/kernel/debug/devices_deferred
>   48070000.i2c:twl at 48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
> 
> This information could be obtained partially by enabling debugging, but it
> means that the kernel log has to be parsed and the probe deferral balanced
> with the successes. This can be error probe and has to be done in a ad-hoc
> manner by everyone who needs to debug these kind of issues.
> 
> Since the information is already known by the kernel, just show it to make
> it easier to debug.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>

This doesn't apply to my tree anymore :(

Can you rebase and resend?

thanks,

greg k-h
