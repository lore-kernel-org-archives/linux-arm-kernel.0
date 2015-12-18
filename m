From: m.silentcreek@gmail.com (m.silentcreek at gmail.com)
Date: Fri, 18 Dec 2015 12:22:40 -0800 (PST)
Subject: BUG - Bananapi USB not working on Mainline
In-Reply-To: <CAOP4N=_Ux0FPSRep7AfBVovd59LeDTbBjH=LBdfWDb6Mc3e=Fg@mail.gmail.com>
References: <CAOP4N=_Ux0FPSRep7AfBVovd59LeDTbBjH=LBdfWDb6Mc3e=Fg@mail.gmail.com>
Message-ID: <2331a2bf-bcdc-4653-9098-65d263d57d1b@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

Am Mittwoch, 16. Dezember 2015 02:47:40 UTC+1 schrieb David Tulloh:
> Hi,
> 
> I am working on a SinoVoip Bananapi M1
> 
> With the current mainline  USB does not work. I believe that power to the USB vbus is being disabled during boot.
> 
> Failing build v4.4-rc5
> Working build v4.2.3
> 
> Compiled with
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sunxi_defconfig menuconfig zImage dtbs
> 
> The boot log is attached, debug and CONFIG_REGULATOR_DEBUG were enabled.
> The config file is also attached.
> 
> 
> I am happy to do further work on the problem but my unfamiliarity with the kernel means I'm flailing in the dark.
> 
> 
> 
> David

I can confirm there is an issue with USB (not OTG) on the Bananapi in Linux 4.4-rc5. I just compiled and booted a 4.4-rc5 kernel image with a new dtb - or be more precise, I failed to boot it because the kernel couldn't mount the usb drives that I listed in my fstab. The defconfig I used was basically the same that I use for my 4.1.y kernels which is based on sunxi_defconfig but adds a lot more stuff like drivers, netfilter, etc (I merged the changes that happened in sunxi_defconfig between 4.1 and 4.4, though).

I haven't had the time yet to look into it further to bisect the issue. I also haven't tried any other kernel versions between 4.1.15 and 4.4-rc5, so I can't say when the problem slipped in. I just can say that there is an issue on my Lemaker Bananapi. The symptoms are the same as descrived by David. My usb drives don't seem the get power anymore once the kernel boots.

I'll try to find time to look into it in more detail over the weekend and provide configs and logs.

Regards,

Timo
