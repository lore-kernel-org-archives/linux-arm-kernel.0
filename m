From: tonyho.profession@gmail.com (TonyHo)
Date: Sun, 16 Feb 2014 13:11:47 +0000 (UTC)
Subject: [linux-pm] ARM hibernation / suspend-to-disk
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
Message-ID: <loom.20140216T140206-196@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Capella <sebastian.capella <at> linaro.org> writes:

> 
> Quoting Pavel Machek (2014-01-28 06:14:58)
> > > > what's the status of suspend-to-disk on ARM? The most recent 
discussion I
> > > > found is:
> > > > http://lists.linuxfoundation.org/pipermail/linux-pm/2012-
November/034997.html
> > > > 
> > > > with no replies at all. Is anyone still working on that? Anyone got 
it running?
> 
> Hi Pavel, Russ,
> 
> I have been looking and working with Russ' most recent branch based
> on the 3.12 kernel, which includes the big pile of patches for OMAP.
> (https://github.com/russdill/linux/commits/arm-hibernation-am33xx-v3.12)
> 
> He has hibernation mostly working and I have been able to run 1400 or
> so entry/exits overnight there on beaglebone black without issue.
> Combining this with device activity has been tricky.  An active
> network will lose the link on restore.  Active SD traffic will
> eventually hang (Last night ran for about 11 hours before hanging
> after ~350 or so hibernations).  I have not found where this is or
> the cause.
> 
> > > For ARM hibernation support to get merged, there needs to be at least
> > > one platform that supports it. the am335x code I have is not ready as 
it
> > > still relies on PM patchsets that have not yet themselves been merged.
> > 
> > Given that we have chicken-and-egg problem here, I believe it makes 
sense
> > to merge generic ARM hibernation support now.
> 
> If you want to go ahead with upstreaming the base patch, Russ, would you
> like me to do that for you or will you have time to do this?
> 
> Otherwise, I am still looking at how to get this upstream by verifying
> on omap 5.  In my case, I still have the chicken egg problem, where I'm 
> trying to verify on omap 5 with out of tree patches.
> 
> Thanks,
> 
> Sebastian
> 

Hi Sebastian ,Pavel ,Russ:
 I want to build the kernel https://github.com/russdill/linux/commits/arm-
hibernation-am33xx-v3.12 to be used in BeagleBone black too, after I clone 
and checkout the branch, I'm not sure whether my opration is right, can 
someone help me to comfirm?
Below is my operation:
1. make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-
none-linux-gnueabi- omap2plus_defconfig . Is the omap2plus_defconfig is 
right configuration file?
2. russdill says his board is BeagleBone(http://www.youtube.com/watch?
v=3hdbH-Ur-hE), so if there would be some modificaiton to be done before 
compile this source code? 
3. Is there any intructions about using and compiling the hibernation source 
code?
