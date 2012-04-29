From: linux@baker-net.org.uk (Adam Baker)
Date: Mon, 30 Apr 2012 00:11:16 +0100
Subject: [patch v2 3/3] kirkwood: Add iconnect support
In-Reply-To: <87zk9yx04n.fsf@lebrac.rtp-net.org>
References: <20120418211638.691400727@rtp-net.org>
 <201204252345.07721.linux@baker-net.org.uk>
 <87zk9yx04n.fsf@lebrac.rtp-net.org>
Message-ID: <201204300011.17388.linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 April 2012, Arnaud Patard wrote:
> Adam Baker <linux@baker-net.org.uk> writes:
> 
> Hi,
> 
> > On Wednesday 18 April 2012, Arnaud Patard wrote:
> >> Add support for Iomega Iconnect system.
> >> 
> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> > 
> > Arnaud,
> > 
> > I have so far been unable to get a kernel to boot with your patches. I
> > just get
> > 
> > Uncompressing Linux... done, booting the kernel.
> 
> hm. sounds weird. Are you sure that you have the DTB appended to your
> kernel image ?

Yes, if I don't append the DTB and I set ArcNumber to 1682 then it boots using 
the ref board setup, if the DTB is appended then it doesn't boot (I configured 
the kernel to support iconnect, dreamplug and RD-88F6281)

> > I've also hit the issue of the stock U-Boot not supporting DTB so am
> > running with
> > CONFIG_ARM_APPENDED_DTB=y
> > CONFIG_ARM_ATAG_DTB_COMPAT=y
> > Have you been using the latter option or are you just using the settings
> > in your dtb file? I'm assuming that you are running with an initrd, so
> > far I've
> 
> It depends on what your boot media is. For instance if you boot your
> kernel and the rootfs on usb and necessary modules built-in you can boot
> directly with things like root=/dev/sdaX rootwait.
> 

That's exactly how I had been booting it with my old kernel, I was just 
wondering what your setup is to help narrow down the difference that means 
yours works and mine doesn't.

> > been trying to run without one hence I was hoping to be able to set the
> > rootfs location on the kernel command line.
> 
> either you use ARM_ATAG_DTB_COMPAT and set the command line on from
> uboot or you don't set it and set the command line from the dts file.
> 

I tried disabling ARM_ATAG_DTB_COMPAT and setting my desired command line in 
the dts but that didn't help. I'll have to give some thought to what to try 
next.

Adam

P.S. I note your LED names don't have the platform name in fromnt of them - I 
thought that was normally included to avoid any confusion with LED names for 
attached peripherals.
