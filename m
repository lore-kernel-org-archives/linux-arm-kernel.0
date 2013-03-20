From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Mar 2013 11:08:09 +0800
Subject: [PATCH V4 0/9] Add mandatory regulator for all users of
 pwm-backlight.
In-Reply-To: <51491DF0.10408@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <20130320021442.GB20443@S2101-09.ap.freescale.net>
 <51491DF0.10408@nvidia.com>
Message-ID: <20130320030806.GA26941@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 11:24:48AM +0900, Alex Courbot wrote:
> On 03/20/2013 11:14 AM, Shawn Guo wrote:
> >On Tue, Mar 19, 2013 at 11:59:24AM -0700, Andrew Chew wrote:
> >>Many backlights are enabled via GPIO.  We can generalize the GPIO to a
> >>fixed regulator.
> >>
> >I think we should push the series of "Runtime Interpreted Power
> >Sequences" moving forward, which should be useful this case and many
> >other cases as well.
> >
> >http://thread.gmane.org/gmane.linux.kernel/1395912
> 
> That's still the medium-term plan. But doing this correctly requires
> some improvements to be done in the GPIO subsystem, which I am
> pushing at the moment.
> 
Thanks for updating the status.

> Eventually power sequences should handle this kind of scenario, but
> by the meantime it cannot hurt to get the job done.
> 
It just makes us a little sick that a dummy fixed regulator is added
all over the places merely for pwm-backlight to retrieve a GPIO from
device tree.

Shawn
