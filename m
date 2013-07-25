From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 17:26:39 +0900
Subject: Mainline kernel on snowball
In-Reply-To: <20130725075203.GE31954@1wt.eu>
References: <20130725052317.GA25854@verge.net.au>
 <20130725054036.GD31954@1wt.eu>
 <20130725072525.GC7654@verge.net.au>
 <20130725075203.GE31954@1wt.eu>
Message-ID: <20130725082639.GA25311@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 09:52:03AM +0200, Willy Tarreau wrote:
> On Thu, Jul 25, 2013 at 04:25:25PM +0900, Simon Horman wrote:
> > > # cat /proc/cmdline 
> > > console=tty0 console=ttyAMA2,115200n8  root=UUID=018e1580-e7e9-460b-95c5-236f6b87b13d rootwait ro fixrtc nocompcache vmalloc=300M mem=128M at 0 mali.mali_mem=64M at 128M hwmem=168M at 192M mem=22M at 360M mem_issw=1M at 383M mem=640M at 384M
> > 
> > Thanks. Rummaging around in the environment present in uboot I came up with
> > the following:
> > 
> > bootargs=cachepolicy=writealloc noinitrd init=init board_id=1 crashkernel=crashkernel=1M at 0x5600000 logo.nologo startup_graphics=1 mpcore_wdt.mpcore_margin=359 loglevel=8 console=ttyAMA2,115200n8 mem=128M at 0 mali.mali_mem=64M at 128M
> > mem=24M at 192M hwmem=167M at 216M mem_issw=1M at 383M mem=640M at 384M vmalloc=256M
> > 
> > Unfortunately neither this, nor the boot args you are using seem
> > to get me any further.
> 
> OK, I'm attaching the config that works for me on 3.10-rc5 (not
> tested a new one yet). It boots with the cmdline above and with
> the DTB from the kernel.
> 
> Hoping this helps,
> Willy
> 

Thanks! I have something working now.

It seems that part of my problem may have been the compiler that
I was using. But that is just speculation at this time.
