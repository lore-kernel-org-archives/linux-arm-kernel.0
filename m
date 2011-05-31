From: rientjes@google.com (David Rientjes)
Date: Tue, 31 May 2011 13:03:03 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110531072650.GC21382@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
	<20110529215656.GA5576@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
	<20110531072650.GC21382@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105311253510.5646@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011, Russell King - ARM Linux wrote:

> Enabling CONFIG_ZONE_DMA is not a fix, it's making the problem vanish off
> the radar.  It will mean that the drivers using GFP_DMA will never get
> fixed up.
> 

Disabling CONFIG_ZONE_DMA is an optimization, do you agree?  I asked 
on Sunday what the downsides of enabling the option on arm are, and you 
didn't mention any.  So what's the problem with my patch to enable it for 
this driver since it is using GFP_DMA?  You claim that it'll never get 
removed again to return to the _optimized_ case, yet my patch is 
guaranteed to work for that driver in all configurations at the moment.  I 
don't think we should be fighting for the optimized case where the 
alternative has no downside.

 [ Patching the page allocator to also emit a line to the dmesg to direct 
   users directly to enabling CONFIG_ZONE_DMA wouldn't be a problem, 
   either. ]

> Change it to be a soft WARN_ON for one release.  Anything else will just
> result in the problem being IGNORED.
> 

The problem certainly isn't being ignored in this thread, or in the patch 
that I sent to fix Dmitry's issue by default, so that doesn't seem to be 
the case.  What would be ignored, though, is if it just emitted a 
WARN_ON() without failing the allocation so everything works perfectly.
