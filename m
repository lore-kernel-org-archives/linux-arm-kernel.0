From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 17:36:44 +0200
Subject: [PATCH 2/2] ARM: ux500: Enable HIGHMEM in the u8540 defconfig
In-Reply-To: <20130531151850.GC12488@gmail.com>
References: <1370010272-25520-1-git-send-email-lee.jones@linaro.org>
 <38058740.G1EqTG95pA@wuerfel> <20130531151850.GC12488@gmail.com>
Message-ID: <1902994.0Kq6C7Rx1R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 16:18:50 Lee Jones wrote:
> On Fri, 31 May 2013, Arnd Bergmann wrote:
> 
> > On Friday 31 May 2013 15:24:32 Lee Jones wrote:
> > > In order to utilise all of the memory located on ux500 based devices
> > > we have to enable HIGHMEM. Without it the kernel truncates memory down
> > > to what's left after the PAGE_OFFSET has been applied, which doesn't
> > > leave an awful lot, especially if we're running large rootfs' such
> > > as full Linux desktop distributions or Android.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > How much memory do those devices have? Enabling HIGHMEM is quite expensive.
> 
> Another 1GB.

You mean you have 2GB total or 1.75GB?  You could just use
CONFIG_VMSPLIT_2G to an extra GB compared to the default, which
is what vexpress, imx and s5p already do, but you still have to
put the vmalloc area in the low 2GB then.

	Arnd
