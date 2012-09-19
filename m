From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 19 Sep 2012 08:04:22 +0300
Subject: Kernel panic - not syncing: No init found
In-Reply-To: <1347882577.12909.YahooMailNeo@web133203.mail.ir2.yahoo.com>
References: <1347466702.70460.YahooMailNeo@web133201.mail.ir2.yahoo.com>
 <20120915190422.GB4434@tarshish>
 <1347882577.12909.YahooMailNeo@web133203.mail.ir2.yahoo.com>
Message-ID: <20120919050421.GB11255@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ellis,

On Mon, Sep 17, 2012 at 12:49:37PM +0100, Ellis Andrew wrote:
> I have done a bit of searching around, and I'm not sure how to boot into 
> initrmafs. Can you please point me towards some instructions on how to do 
> this.

See Documentation/filesystems/ramfs-rootfs-initramfs.txt in (recent) kernel 
source tree. See also http://www.landley.net/writing/rootfs-howto.html by the 
same author.

baruch

> ________________________________
>  From: Baruch Siach <baruch@tkos.co.il>
> To: Ellis Andrew <ajellisuk@yahoo.co.uk> 
> Cc: "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org> 
> Sent: Saturday, 15 September 2012, 20:04
> Subject: Re: Kernel panic - not syncing: No init found
>  
> Hi Ellis,
> 
> On Wed, Sep 12, 2012 at 05:18:22PM +0100, Ellis Andrew wrote:
> > After a lot of searching with Google I have found this is a common problem, 
> > unfortunately none of the solutions I have found, fix the problem.
> > 
> > The original error I got was:
> > 
> > Kernel panic - not syncing: No init found.? Try passing init= option to kernel.
> > 
> > The command line option was:
> > root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyMCS mem=64M at 0x0
> > 
> > I after digging around with google, I found a suggestion which I tried, I made my command line:
> > root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyMCS mem=64M at 0x0 init=/sbin/init panic=4
> > 
> > But I now get the following error:
> > 
> > Freeing init memory: 88K
> > Failed to execute /sbin/init.? Attempting defaults...
> > Kernel panic - not syncing: No init found.? Try passing init= option to kernel.
> > 
> > I can see that the Root drive is being mounted.
> > 
> > The contents of the init file is:
> > 
> > #!/bin/busybox ash
> > /bin/busybox mount -t sysfs /dev/sys /sys
> > /bin/busybox mount -t proc? /proc
> > /bin/busybox mount -t devpts /dev/pts
> > # Populate /dev according to /sys
> > /bin/busybox mdev -s
> > /bin/busybox --install -s
> > /linuxrc
> > exec /sbin/init "$@"?? </dev/console >/dev/console 2>&1
> > 
> > Does anyone have any suggestions on how to fix this please? 
> 
> The most common reason for this failure is that your root filesystem layout is 
> not what you think it is. Try booting into initramfs and mounting your jffs2 
> filesystem from there to examine it directly on your running system.
> 
> baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
