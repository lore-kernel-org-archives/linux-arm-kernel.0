From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 04 Mar 2014 16:16:43 -0800
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <5315B328.9030306@gmail.com>
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
 <loom.20140216T140206-196@post.gmane.org>
 <20140224215443.9748.65580@capellas-linux> <5312E46B.8020900@gmail.com>
 <531560aa.e7d5440a.0e5f.5f57@mx.google.com> <5315B328.9030306@gmail.com>
Message-ID: <53166cef.43bd440a.2ff1.472e@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting TonyHo (2014-03-04 03:04:08)
> Hi Sebastian:
>      Thank you. And I'm in Shanghai, it's not far from the Macao, both 
> in China, ha.
> The system can boot up normal now. And I want to make the hibernation, 
> but error occurs. I want to save the hibernation image in 
> /dev/mmcblk0p3(device id 179:3), and I configure this in menuconfig:
> / # cat /sys/power/resume 179:3
> When I echo a disk to /sys/power/state , it hints(partly log):
> [ 49.426656] omap_uart 44e09000.serial: no wakeirq for uart0
> [ 49.594385] PM: thaw of devices complete after 171.291 msecs
> [ 49.661876] PM: Cannot find swap device, try swapon -a.
> [ 49.667356] PM: Cannot get swap writer
> [ 49.722677] Restarting tasks ... done. ash: write error: No such device
> 
> But I can find my device /dev/mmcblk0p3, and its size is about 2GB, and 
> it's not mounted in system,it can be mounted with ext4 filesystem.
> / # ls -l /dev/mmcblk*
> brw-rw---- 1 0 0 179, 3 Jan 1 00:01 /dev/mmcblk0p3
> 
> It says cannot find swap device, but the CONFIG_SWAP=y is checked.
> It seems I miss something?

Hi tony,
          
Two things are?missing:

1) you must format the partition as swap using the mkswap command. ?This can be
   done on target or on your laptop. ?

2) after booting, on target you have to add the swap to the system using the
   swapon command. ?I usually do:

    swapon /dev/mmcblk0p3

If you want to do swapon -a you may have to modify the
/etc/fstab or mnttab but I don't do it?this way. ?

Sebastian
