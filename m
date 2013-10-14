From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 Oct 2013 14:36:33 -0400
Subject: [PATCH] ARM: mvebu: dts: remove unneeded linux,default-state
 from led nodes
In-Reply-To: <20131014182821.GD25095@lunn.ch>
References: <1381774047-23354-1-git-send-email-jason@lakedaemon.net>
 <20131014182821.GD25095@lunn.ch>
Message-ID: <20131014183633.GK5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 08:28:21PM +0200, Andrew Lunn wrote:
> On Mon, Oct 14, 2013 at 06:07:27PM +0000, Jason Cooper wrote:
> > Generally, power LEDs should indicate when power is applied, and go out
> > once power is removed.  _Not_ annoy the developer with migraine-inducing
> > blinking reminicent of some badly animated television series designed to
> > sell sugar to children.
> > 
> > On a more serious note, most of these OS-specific properties aren't
> > necessary and should be removed.  I left two that are legitimately tying
> > disk LEDs to disk activity.  Other than that, we keep the state the
> > bootloader left them in until userspace changes the state via sysfs.
> 
> Hi Jason
> 
> Do you know what happens with "keep" and the bootloader setting the
> LED to hardware blink? I'm just wondering if some of these default-on,
> are actually disabling hardware blinking and making it constant on?

hmmm, good question.  I'll let this patch sit for some time since it is
trivial and doesn't conflict with anything in mvebu/dt.  We'll see if
anyone says anything.

Regardless of the outcome, 'default-state = "on";' can be used instead
for that scenario.

thx,

Jason.
