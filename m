From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 17:32:11 +0800
Subject: Error of 'handle_local_timer' missing in plat-mxc/gic.c when
 building 'mx5-merge' branch
In-Reply-To: <CAMPhdO8ArDykEgXn6rdttPF3d6c_MUB4Bukh85VMNCYwg9Ezjw@mail.gmail.com>
References: <CAMPhdO8ArDykEgXn6rdttPF3d6c_MUB4Bukh85VMNCYwg9Ezjw@mail.gmail.com>
Message-ID: <20111206093210.GB3864@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 04:40:32PM +0800, Eric Miao wrote:
> Hi Sascha,
> 
> Just FYI,
> 
>   CC      arch/arm/plat-mxc/gic.o
> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c: In function 'gic_handle_irq':
> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c:44:4: error: implicit
> declaration of function 'handle_local_timer'
> make[2]: *** [arch/arm/plat-mxc/gic.o] Error 1
> make[1]: *** [arch/arm/plat-mxc] Error 2
> make: *** [sub-make] Error 2
> 
> Do we have a fix somewhere already?
> 
Patch a918fee (ARM: mxc: fix local timer interrupt handling) on mainline
should be the fix.

-- 
Regards,
Shawn
