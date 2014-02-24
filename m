From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 24 Feb 2014 13:54:43 -0800
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <loom.20140216T140206-196@post.gmane.org>
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
 <loom.20140216T140206-196@post.gmane.org>
Message-ID: <20140224215443.9748.65580@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting TonyHo (2014-02-16 05:11:47)
> Hi Sebastian ,Pavel ,Russ:
>  I want to build the kernel https://github.com/russdill/linux/commits/arm-
> hibernation-am33xx-v3.12 to be used in BeagleBone black too, after I clone 
> and checkout the branch, I'm not sure whether my opration is right, can 
> someone help me to comfirm?
> Below is my operation:
> 1. make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-
> none-linux-gnueabi- omap2plus_defconfig . Is the omap2plus_defconfig is 
> right configuration file?
> 2. russdill says his board is BeagleBone(http://www.youtube.com/watch?
> v=3hdbH-Ur-hE), so if there would be some modificaiton to be done before 
> compile this source code? 
> 3. Is there any intructions about using and compiling the hibernation source 
> code?

Hi Tony,

I use omap2plus_defconfig.  

I have been working with BeagleBone Black (bbb) for hibernation on this branch:

http://git.linaro.org/git-ro/people/sebastian.capella/linux.git hibernation_3.13_russMerge

I ran into a few minor issues on Russ' branch for bbb that I had to work
around.  In the end it worked fine, but I know I had to add some entries
in the dts files at least for it to work.

On bbb I'm resuming from initramfs by echoing the hibernation
swap device onto /sys/power/resume during my initscript, but before
remounting the partitions.  You may need to do similar.

You will have to change power managemennt -> hibernation to on in
menuconfig.

I can help more, please let me know what you have and how you'd like to
set it up.

Thanks!

Sebastian
