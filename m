From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jun 2016 14:30:02 +0100
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm via
 the cmdline
In-Reply-To: <5767E89F.5020809@linaro.org>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
 <5766FBC6.6000405@linaro.org> <20160620082157.GC29165@arm.com>
 <5767E89F.5020809@linaro.org>
Message-ID: <20160620133001.GE29165@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 02:59:11PM +0200, Daniel Lezcano wrote:
> On 06/20/2016 10:21 AM, Will Deacon wrote:
> >On Sun, Jun 19, 2016 at 10:08:38PM +0200, Daniel Lezcano wrote:
> >>On 06/17/2016 03:43 PM, Will Deacon wrote:
> >>
> >>[ Cc'ed tglx ]
> >>
> >>>Disabling the eventstream can be useful for debugging and development
> >>>purposes
> >>
> >>If it is for debugging and development, why upstream this change ?
> >
> >Mainly because it's desirable to be able to debug systems remotely, on
> >machines that you don't have direct access to and where recompiling the
> >kernel isn't necessarily an option. There are plenty of "no*" kernel
> >parameters already that fall into a similar category.
> 
> if the kernel is in development and debug, why this option can't be part of
> debugging code ?
> 
> If recompiling isn't an option, how this can be for "debugging and
> development" ?

Sorry, I wasn't very clear. The sort of use-case I'm envisaging is where
somebody is running a distro kernel on non-public hardware and sends me an
email about spinlock performance. Being able to disable the event stream
easily is a powerful tool in the small box of remote debugging tools and
would be useful in pinning down things like missing events.

So when I say "development and debug" I'm really thinking about *remote*
debug via a user, and then potentially the subsequent development of a
patch.

> I'm not a big fan of the all the specific driver options for the kernel
> parameters. If there is a real need to disable some parts of a driver, it
> would be much more interesting to write a framework for that and then use it
> from arm_arch_timer, thus giving the other drivers the opportunity to
> provide the same feature.

Such a framework sounds horribly ill-specified and far beyond the scope
of the simple change I'm proposing here. Are you planning to submit
patches for this?

Will
