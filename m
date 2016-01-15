From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 16 Jan 2016 00:00:39 +0200
Subject: mvsdio not working on OpenRD
In-Reply-To: <20160115192217.GA12145@jirafa.cyrius.com>
References: <20160110042619.GA22738@jirafa.cyrius.com>
 <20160110153843.GA22229@lunn.ch>
 <20160115180339.GC18908@darkstar.musicnaut.iki.fi>
 <20160115192217.GA12145@jirafa.cyrius.com>
Message-ID: <20160115220039.GD18908@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 15, 2016 at 11:22:17AM -0800, Martin Michlmayr wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [2016-01-15 20:03]:
> > On Sun, Jan 10, 2016 at 04:38:43PM +0100, Andrew Lunn wrote:
> > > If i remember correctly, the OpenRD has some odd muxing going on with
> > > MMC and the second serial port. This fits the error message:
> 
> Andrew, your memory is good!  I looked at the old board file and
> noticed there used to be a kw_openrd_init_uart1 kernel option to
> choose.  The default was MMC (this was not a Debian choice, but one
> from kernel.org), so I think that should become the default again.
> 
> See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/diff/arch/arm/mach-kirkwood/openrd-setup.c?id=ba364fc752daeded072a5ef31e43b84cb1f9e5fd
> 
> Rick Thomas did some tests we came to the conclusion that MMC on DTB
> doesn't work, even with your patch.  We established that the same
> kernel (3.16) works with the board file but not with DTB.  I was about
> to send an udpate when I saw Aaro's email.
> 
> I suggested we put in both of these patches.  I'll produce a test
> kernel for Rick with Aaro's patch.
> 
> > In addition, the UART/SD selection GPIO needs to be set up. I sent a
> > patch proposal for this:
> > 	http://marc.info/?l=linux-arm-kernel&m=145262936504783&w=2
> 
> Thanks!

BTW, the GPIO hogging binding used in the patch might not be supported
by the old Debian 3.16 kernel. :-(

One workaround would be to setup the GPIO from userspace using sysfs,
but that would need replug of the SD card (unbind/bind, or if the driver
a module unload/reload, might work), but that's quite clumsy...

A.
