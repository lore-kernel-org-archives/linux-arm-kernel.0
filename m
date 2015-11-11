From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 11 Nov 2015 15:55:57 +0800
Subject: [PATCH v5 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <7h1tbx1gjp.fsf@deeprootsystems.com>
References: <1443799181-50409-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443799181-50409-5-git-send-email-yingjoe.chen@mediatek.com>
 <CAMAWPa-Ed2FJY2pW67EHHKBH3_eBZx0+oWfMJwc_DhEjrf7aMg@mail.gmail.com>
 <1445843717.23888.1.camel@mtksdaap41>
 <CAMAWPa_Gyq7H0qUJ32PAJh_ELdHeKWMPyHud4gaT8=Ootcu1+g@mail.gmail.com>
 <1445859610.26723.4.camel@mtksdaap41>
 <CAMAWPa_13j88SMBbYEBg2WHFEhkhR_gVZkkU_x-U5NJay05AxA@mail.gmail.com>
 <1447135867.14454.9.camel@mtksdaap41> <7h1tbx1gjp.fsf@deeprootsystems.com>
Message-ID: <1447228557.20886.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, 2015-11-10 at 17:16 -0800, Kevin Hilman wrote:
> Hi Eddie,
> 
> [...]
> 
> > I check the log [0],
> 
> Thanks for checking into this boot failure.
> 
> > it seems first time mt8135-evbp1 boot to kernel
> > shell successfully, then boot again. In the second time, mt8135 stay in
> > fastboot mode, waiting host send boot image, then timeout.
> 
> Actually, it never gets to a shell the first time.  If you look closely,
> the target reboots as soon as userspace starts.   Look for the PYBOOT
> line which says "finished booting, starting userspace"
> 
> Later on, pyboot thinks it finds a root shell due to finding '#'
> characters, but clearly it never got to a shell.
> 
> > I download zImage and dtb in [1], and kernel run to shell successfully
> > on my platform.
> 
> Are you can you try using a ramdisk as well?  You can use the pre-built
> one here:
> http://storage.kernelci.org/images/rootfs/buildroot/armel/rootfs.cpio.gz
> 

Yes, I tried this ramdisk, and I can reproduce fail issue.

> Please check my boot logs to see how I'm generating the boot.img file
> (search for mkbootimg) with a kernel/dtb/ramdisk.  It may be possible
> that the kernel image size with a ramdisk is breaking some of the
> assumptions in the fastboot mode.  I've seen problems like this on other
> platforms due to hard-coded sizes/addresses in the boot firmware.
> 

MT8135 allocate 10MB for BOOT partition, but the test boot.img is 11MB,
thus cause user space fail. I will prepare new firmware that extend BOOT
partition to 16MB. and put new firmware on Howard's github. I will mail
to you when I am ready..

Eddie
Thanks
