From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Feb 2013 23:19:18 +0100 (CET)
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <51263975.20906@ti.com>
References: <CAB4PhKevqf0e4nzYraE9ZTAFbPCFfNpguAnPoVpJh-FFe2TAZA@mail.gmail.com>
 <alpine.LFD.2.02.1302201400400.22263@ionos>
 <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
 <alpine.LFD.2.02.1302211015270.22263@ionos>
 <CAB4PhKf+Z-TK4KGDZm1kYOWibg=e2Ehnhjxt_oTbFq9eqouAjA@mail.gmail.com>
 <alpine.LFD.2.02.1302211436300.22263@ionos> <51263975.20906@ti.com>
Message-ID: <alpine.LFD.2.02.1302212214020.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Feb 2013, Santosh Shilimkar wrote:
> On Thursday 21 February 2013 07:18 PM, Thomas Gleixner wrote:
> > find below a completely untested patch, which should address that issue.
> > 
> After looking at the thread, I tried to see the issue on OMAP and could
> see the same issue as Jason.

That's interesting. We have the same issue on x86 since 2007 and
nobody noticed ever. It's basically the same problem there, but it
seems that on x86 getting out of those low power states is way slower
than the minimal reprogramming delta which is used to enforce the
local timer to fire after the wakeup. 

I'm still amazed that as Jason stated a 1us reprogramming delta is
sufficient to get this ping-pong going. I somehow doubt that, but
maybe ARM is really that fast :)

> Your patch fixes the retries on both CPUs on my dual core machine. So
> you use my tested by if you need one.

They are always welcome.

> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Thanks for the patch.
> And thanks to Jason for spotting the issue.

And for coping with my initial inability to parse his report!

Thanks,

	tglx
