From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Jul 2013 05:24:17 -0700
Subject: [PATCH 0/4] pinctrl single support for SoC specific features
In-Reply-To: <51DD4F30.7050603@ti.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <51DD4F30.7050603@ti.com>
Message-ID: <20130710122417.GT5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130710 05:16]:
> Hi Tony,
> 
> On 06/07/2013 11:50 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here are few patches to add support for SoC specific features
> > to pinctrl-single. This is needed at least for omaps to support
> > IO chain wake-up events from deeper idle states.
> > 
> > With this patch series, device drivers can request named pinctrl
> > states like active and idle from the PM runtime suspend and resume
> > calls to set the wake enable bits for selected pins. Further
> > the device driver can toggle the wake-up feature as needed based on
> > the device_may_wakeup() state set by the standard sysfs
> > power/wakeup entry.
> > 
> > This is implemented in a separate pinctrl-single-omap driver that
> > works together with pinctrl-single. This way the SoC specific
> > are separated from the common pinctrl-single, and allows a relatively
> > easy way to implement SoC specific things like wake-up events,
> > pin interrupts, and GPIO.
> 
> What's the status of this? Would be nice to get it in 3.12. I'm basing
> the OMAP USB host wakeup support on this.

How about I'll push an immutable branch against v3.11-rc1 when it's
tagged and send a pull request to Linus W for the first three patches?

That way we can base other branches on this if needed.

Linus, does that sound OK to you?

Regards,

Tony
