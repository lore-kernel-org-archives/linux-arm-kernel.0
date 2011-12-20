From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Dec 2011 13:54:00 -0500 (EST)
Subject: [PATCH 17/20] ARM: mach-s3c64xx: properly disable CPU idle call
In-Reply-To: <20111220150302.GE29727@sirena.org.uk>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-18-git-send-email-nico@fluxnic.net>
 <20111220150302.GE29727@sirena.org.uk>
Message-ID: <alpine.LFD.2.02.1112201348430.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Dec 2011, Mark Brown wrote:

> On Mon, Dec 19, 2011 at 04:47:46AM -0500, Nicolas Pitre wrote:
> 
> >  void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
> >  {
> > +	disable_hlt();  /* idle WFI usage needs to be confirmed */
> > +
> 
> I'm not sure what the intention of the comment is but the CPU can use
> WFI to idle (I've got a cpuidle driver which I've posted which does the
> basics and some more updates in the pipeline).

Still, the code as it is before this patch doesn't use it given the 
empty arch_idle().  So I'm only providing the same behavior in a 
different form.

So if you can confirm the kernel works fine with that disable_hlt() 
commented out (while still including the rest of the patch) then I can 
change the patch.  And if you can measure a difference in power 
consumption when the system is idle then that would be even better.


Nicolas
