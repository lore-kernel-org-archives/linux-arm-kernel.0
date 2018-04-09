From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Apr 2018 15:31:23 +0100
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180409135852.GA22168@arthur-bzh>
References: <20180320100427.GA21933@arthur-bzh>
 <20180320104302.GG2743@n2100.armlinux.org.uk>
 <20180320150723.GH2743@n2100.armlinux.org.uk>
 <20180320171608.GB32282@arthur-bzh>
 <20180320191259.GI2743@n2100.armlinux.org.uk>
 <20180321132548.GA32618@arthur-bzh>
 <20180329205413.GG16141@n2100.armlinux.org.uk>
 <20180409135852.GA22168@arthur-bzh>
Message-ID: <20180409143123.GA4251@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:58:52PM +0200, Arthur LAMBERT wrote:
> Russell,
> 
> I was finally able to make it work by using mainline kernel (v4.16-rc7) :

Great, what was the solution in the end?

>    kernel command line: "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw earlyprintk maxcpus=1 reset_devices elfcorehdr=0x9b100000 mem=50176K"

This is the command line which the target kernel should boot with, but...

> [    0.000000] Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw crashkernel=50M

it appears that it hasn't, so something is still wrong.  Without the
right command line, you won't get the vmcore.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
