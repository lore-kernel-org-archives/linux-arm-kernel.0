From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 14:49:11 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4OzF9KV=51yAR2pVHJZNQsGDkXVhBwbn4njhZPRjeh=-dA@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de>
 <CAKON4OzF9KV=51yAR2pVHJZNQsGDkXVhBwbn4njhZPRjeh=-dA@mail.gmail.com>
Message-ID: <201203231449.12209.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 March 2012, jonsmirl at gmail.com wrote:
> > In particular, in order to enable the multiplatform kernel, we have
> > to restrict access of device drivers to platform specific header file
> > in all cases where those have conflicting contents.
> 
> Isn't this a symptom of not having device trees? If the devices are
> identical the header files should be identical except for the base
> address. The device tree allows you to get that base address out of
> the header file.

Well, device trees are not the only solution that works for this.
You can also get the base address out of statically declared platform
devices in the platform code. The problem here is not the lack
of device trees, but code that is not written to be run time
configured. Moving to device tree requires the same changes though.

> Assuming that we can clear up the conflicts in the header files, then
> wouldn't it make sense to use ioremap in the  driver, let it assign a
> random address, and then fix my code to the base+offset model?

I think that is the right solution in any case, as it helps with
both the multiplatform kernels and device trees.

	Arnd
