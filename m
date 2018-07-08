From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 8 Jul 2018 15:19:50 +0200
Subject: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <bd34c19a-e673-4ce4-e57a-14cc275ab020@redhat.com>
References: <20180627220656.19298-1-javierm@redhat.com>
 <20180707155921.GA26504@kroah.com>
 <bd34c19a-e673-4ce4-e57a-14cc275ab020@redhat.com>
Message-ID: <20180708131950.GA25366@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2018 at 02:31:49AM +0200, Javier Martinez Canillas wrote:
> Hi Greg,
> 
> On 07/07/2018 05:59 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
> >> With Device Trees (DT), the dependencies of the devices are defined in the
> >> DT, then the drivers parse that information to lookup the needed resources
> >> that have as dependencies.
> >>
> >> Since drivers and devices are registered in a non-deterministic way, it is
> >> possible that a device that is a dependency has not been registered yet by
> >> the time that is looked up.
> >>
> >> In this case the driver that requires this dependency cannot probe and has
> >> to defer it. So the driver core adds it to a list of deferred devices that
> >> is iterated again every time that a new driver is probed successfully.
> >>
> >> For debugging purposes it may be useful to know what are the devices whose
> >> probe function was deferred. Add a debugfs entry showing that information.
> >>
> >>   $ cat /sys/kernel/debug/devices_deferred
> >>   48070000.i2c:twl at 48:bci
> >>   musb-hdrc.0.auto
> >>   omapdrm.0
> >>
> >> This information could be obtained partially by enabling debugging, but it
> >> means that the kernel log has to be parsed and the probe deferral balanced
> >> with the successes. This can be error probe and has to be done in a ad-hoc
> >> manner by everyone who needs to debug these kind of issues.
> >>
> >> Since the information is already known by the kernel, just show it to make
> >> it easier to debug.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> Reviewed-by: Mark Brown <broonie@kernel.org>
> > 
> > This doesn't apply to my tree anymore :(
> >
> 
> I see, I made sure that it applied on top of linux-next.
>  
> > Can you rebase and resend?
> >
> 
> I guess you want me to rebase on top of your driver-core-next branch. I think
> that linux-next should pull that branch instead of the driver-core-linus one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n29

Both are in linux-next, it just takes a day or so for the
driver-core-next branch to get merged in.

thanks,

greg k-h
