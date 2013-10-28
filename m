From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 Oct 2013 16:17:30 +0100
Subject: [PATCH] ARM: mvebu: dts: remove unneeded linux,default-state
 from led nodes
In-Reply-To: <20131014183633.GK5402@titan.lakedaemon.net>
References: <1381774047-23354-1-git-send-email-jason@lakedaemon.net>
 <20131014182821.GD25095@lunn.ch>
 <20131014183633.GK5402@titan.lakedaemon.net>
Message-ID: <20131028151729.GA6972@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason, Andrew

On Mon, Oct 14, 2013 at 02:36:33PM -0400, Jason Cooper wrote:
> On Mon, Oct 14, 2013 at 08:28:21PM +0200, Andrew Lunn wrote:
> > On Mon, Oct 14, 2013 at 06:07:27PM +0000, Jason Cooper wrote:
> > > Generally, power LEDs should indicate when power is applied, and go out
> > > once power is removed.  _Not_ annoy the developer with migraine-inducing
> > > blinking reminicent of some badly animated television series designed to
> > > sell sugar to children.
> > > 
> > > On a more serious note, most of these OS-specific properties aren't
> > > necessary and should be removed.  I left two that are legitimately tying
> > > disk LEDs to disk activity.  Other than that, we keep the state the
> > > bootloader left them in until userspace changes the state via sysfs.
> > 
> > Hi Jason
> > 
> > Do you know what happens with "keep" and the bootloader setting the
> > LED to hardware blink? I'm just wondering if some of these default-on,
> > are actually disabling hardware blinking and making it constant on?

This is the reason why I used the default-on in kirkwood-ib62x0.dts
at the time.  The original bootloader did enable hardware blinking. 
(Can't check whether "keep" would at least disable the blinking,
since I don't have the original bootloader on the box anymore)

For obvious reasons, the uboot support for the IB NAS 62x0 does not
copy this behavior from the original uboot. So, it is not
an issue anymore once you upgrade the bootloader.  
 
> hmmm, good question.  I'll let this patch sit for some time since it is
> trivial and doesn't conflict with anything in mvebu/dt.  We'll see if
> anyone says anything.

We can see it as a nice incentive to upgrade the boot loader...

> Regardless of the outcome, 'default-state = "on";' can be used instead
> for that scenario.

Sure.

- Simon
