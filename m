From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Feb 2012 14:08:46 -0800
Subject: ARM: OMAP2xxx: PM: remove obsolete timer disable code in the
 suspend path
In-Reply-To: <alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com>
References: <alpine.DEB.2.00.1202092007540.17520@utopia.booyaka.com>
 <alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com>
Message-ID: <20120220220846.GO18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120210 00:10]:
> On Thu, 9 Feb 2012, Paul Walmsley wrote:
> 
> > 
> > Remove omap_{read,write}l() from the 24xx PM code.  The clocksource
> > code should now handle what this was supposed to do.
> > 
> > Tested on N800 -- but it's hard to say whether this fixes anything.
> > OMAP24xx static suspend path is currently broken, and this patch
> > doesn't change that.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Just realized that a stray change made it into the patch that was posted.
> Below is a version with the stray change removed.  It applies on 
> Tony's v3.3-rc3 testing branch, plus the OMAP2420 serial fix patch that 
> was posted earlier.

Thanks I'll apply this into my clean-up branch along with other
io.h changes. I also have fixed omap_read/write for the following
on omap2+:

plat-omap/dma.c
drivers/gpio/gpio-omap.c

Planning to also fix plat-omap/usb.c.

Regards,

Tony
