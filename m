From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Dec 2017 15:30:19 +0530
Subject: [PATCH V4 03/12] drivers: Add boot constraints core
In-Reply-To: <20171213094227.GC13194@kroah.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <2868a37e561cab91ba5495a1e14b9548c8e93c3e.1509284255.git.viresh.kumar@linaro.org>
 <20171213094227.GC13194@kroah.com>
Message-ID: <20171213100019.GB3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:42, Greg Kroah-Hartman wrote:
> On Sun, Oct 29, 2017 at 07:18:51PM +0530, Viresh Kumar wrote:
> > Some devices are powered ON by the bootloader before the bootloader
> > handovers control to Linux. It maybe important for those devices to keep
> > working until the time a Linux device driver probes the device and
> > reconfigure its resources.
> > 
> > A typical example of that can be the LCD controller, which is used by
> > the bootloaders to show image(s) while the platform is booting into
> > Linux. The LCD controller can be using some resources, like clk,
> > regulators, PM domain, etc, that are shared between several devices.
> > These shared resources should be configured to satisfy need of all the
> > users. If another device's (X) driver gets probed before the LCD
> > controller driver in this case, then it may end up reconfiguring these
> > resources to ranges satisfying the current users (only device X) and
> > that can make the LCD screen unstable.
> > 
> > This patch introduces the concept of boot-constraints, which will be set
> > by the bootloaders and the kernel will satisfy them until the time
> > driver for such a device is probed (successfully or unsuccessfully).
> > 
> > The list of boot constraint types is empty for now, and will be
> > incrementally updated by later patches.
> > 
> > Only two routines are exposed by the boot constraints core for now:
> 
> I think we need some documentation somewhere on how to use this, right?

Will add that in next version.

-- 
viresh
