From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 16:08:36 -0600
Subject: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
In-Reply-To: <a5db25f7-6999-ff3a-21c2-161cfcf4db35@kapsi.fi>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
 <c1192f75-0e6e-c735-67e1-2901624831ae@roeck-us.net>
 <a5db25f7-6999-ff3a-21c2-161cfcf4db35@kapsi.fi>
Message-ID: <20180301220836.a77o5i5g7g2k7lei@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 05:20:29PM +0200, Mikko Perttunen wrote:
> On 21.02.2018 16:46, Guenter Roeck wrote:
> > On 02/20/2018 11:15 PM, Mikko Perttunen wrote:
> > > AIUI, the PWM framework already exposes a sysfs node with period
> > > information. We should just use that instead of adding a new driver
> > > for this.
> > > 
> > 
> > I am kind of lost. Please explain.
> > 
> > Are you saying that we should drop the pwm-fan driver as well (which goes
> > the opposite way), as well as any other drivers doing anything with pwm
> > signals,
> > because after all those signals are already exposed to userspace a sysfs
> > attributes,
> > and a kernel driver to abstract those values is thus not needed ?
> 
> The only thing this driver does is do a constant division in kernelspace.
> I'm not really seeing why that couldn't be done in userspace. But if you
> think it's appropriate to do the RPM conversion in kernelspace then I'm not
> greatly opposed to that.
> 
> > 
> > > In any case, we cannot add something like this to device tree since
> > > it's not a hardware device.
> > > 
> > 
> > So you are saying there is no means to express in devicetree that
> > a pwm input is connected to a fan ? How is that not hardware ?
> > 
> > If so, how do you express in devicetree that a pwm signal is connected
> > to anything ?
> 
> If we want to describe that the tachometer is connected to a fan, then we
> should have a fan node in the board's device tree. We don't have a chip that
> has a thing called "generic-pwm-tachometer" attached to it. (We have chips
> that have a "nvidia,tegra186-tachometer", so it's proper to have that.)

We already have some fan control bindings in the tree. Follow those. 
There's only so many ways to control fans, so lets have some alignment. 
And yes, we should have a fan node. 

Rob
