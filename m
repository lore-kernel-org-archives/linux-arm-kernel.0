From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Oct 2014 17:58:35 +0100
Subject: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
In-Reply-To: <543412F7.8040909@landley.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-6-git-send-email-linux@roeck-us.net>
 <543412F7.8040909@landley.net>
Message-ID: <20141007165835.GE27216@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 05:21:11PM +0100, Rob Landley wrote:
> On 10/07/14 00:28, Guenter Roeck wrote:
> > Devicetree bindings are supposed to be operating system independent
> > and should thus not describe how a specific functionality is implemented
> > in Linux.
> 
> So your argument is that linux/Documentation/devicetree/bindings should
> not be specific to Linux. Merely hosted in the Linux kernel source
> repository.

Precisely. If nothing else as a general guideline this keeps us honest,
and prevents us from embedding arbitrary implementation details into
bidnings that cause pain later when we want to change things at either
end.

There are already otehr users of these bindings, so we can't really
claim they're strictly Linux-specific anyhow.

> Well that's certainly a point of view.

As far as I am aware, it's the point of view shared by the device tree
maintainers, and it's been that way for a while.

I don't really follow your concern. For one thing were this followed
more strictly this file wouldn't need patching at all to correct for
this Linux-internal rework...

Thanks,
Mark.
