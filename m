From: John.Linn@xilinx.com (John Linn)
Date: Wed, 30 Mar 2011 07:17:46 -0600
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201103301344.45307.arnd@arndb.de>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<1301444651-18008-3-git-send-email-john.linn@xilinx.com>
	<9ceff117-ad43-4513-bee0-153a93c379ce@VA3EHSMHS008.ehs.local>
	<201103301344.45307.arnd@arndb.de>
Message-ID: <f4872ed7-b6e4-4050-9445-5176f5aa961a@VA3EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, March 30, 2011 5:45 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
> jamie at jamieiles.com
> Subject: Re: [PATCH V5 3/4] ARM: Xilinx: base header files and
assembly
> macros
> 
> Hi John,
> 
> I looked over the latest version of your patches, everything looks
> good to me, but I found one problem that you have probably copied
> from other platforms:

Hi Arnd,

Thanks for taking the time to review again. Yep I did copy from others.

> 
> On Wednesday 30 March 2011, John Linn wrote:
> > +
> > +/* Allow IO space to be anywhere in the memory */
> > +
> > +#define IO_SPACE_LIMIT 0xffff
> > +
> > +/* IO address mapping macros, nothing special at this time but
> required */
> > +
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(x)               (x)
> > +#else
> > +#define IOMEM(x)               ((void __force __iomem *)(x))
> > +#endif
> > +
> > +#define __io(a)                        __typesafe_io(a)
> > +#define __mem_pci(a)           (a)
> 
> The definition of __io() looks wrong, so any call to inb()/outb()
> will be a wild pointer access when you add PCI support.

Yes that makes sense.  We don't have immediate plans for PCI and 
I was assuming when we add PCI we would need to change that.  

If you think I shouldn't put it off then I'll fix it now.  My 
preference was to get the platform supported, then add more features.

Thanks,
John

> 
> If you don't plan to support PCI in the future, there should
> be no problem.
> 
> 	Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
