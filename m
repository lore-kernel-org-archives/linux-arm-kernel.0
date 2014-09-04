From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Sep 2014 09:25:43 -0700
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <54087D94.7000208@linutronix.de>
References: <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de> <54060EDA.6060204@linutronix.de>
 <20140902201536.GC11766@atomide.com>
 <540745CC.2090901@linutronix.de>
 <20140903174845.GE11766@atomide.com>
 <54086CA7.8020507@linutronix.de>
 <20140904145203.GR11766@atomide.com>
 <54087D94.7000208@linutronix.de>
Message-ID: <20140904162542.GS11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140904 07:56]:
> On 09/04/2014 04:52 PM, Tony Lindgren wrote:
> > Yeah makes sense to me. Thanks for ensuring the bug
> > compability :)
> 
> Thanks. What about the ttyOx vs ttySx. Do you want me to add kernel
> line fixup somewhere arch/arm or we ignore this for now? Greg didn't
> say anything?

I suggest we have both drivers just available first and then attempt
to deal with the removal of most of omap-serial later on.

If both drivers are present, we should try to ensure 8250 gets probed
first which I believe it already does based on the Makefile order.

Once the 8250 based driver is known to work, it might make sense to
remove most of the functions in omap-serial and have it use the 8250
functions too to remove duplicate code.

That might be already enough and no proxying is needed and we get
rid of the duplicate code :)

Regards,

Tony
