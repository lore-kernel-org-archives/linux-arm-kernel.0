From: John.Linn@xilinx.com (John Linn)
Date: Tue, 8 Feb 2011 10:11:06 -0700
Subject: [PATCH 3/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <201102081625.57049.arnd@arndb.de>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<20110208143514.GB27521@n2100.arm.linux.org.uk>
	<f3101c62-0bd1-4ad5-8ace-d81a1fd58890@VA3EHSMHS005.ehs.local>
	<201102081625.57049.arnd@arndb.de>
Message-ID: <76dc00d0-89c9-4ae4-a34d-d1045117b08e@VA3EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, February 08, 2011 8:26 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: John Linn; Russell King - ARM Linux; catalin.marinas at arm.com;
glikely at secretlab.ca; Kiran Sutariya
> Subject: Re: [PATCH 3/4] ARM: Xilinx: Adding timer support to the
platform
> 
> On Tuesday 08 February 2011, John Linn wrote:
> > > > +#define PERIPH_BASE            0xF8000000
> > >
> > > should be:
> > >
> > > #define PERIPH_BASE            IOMEM(0xF8000000)
> > >
> > > But then in a different patch you do:
> > > +               .virtual        = TTC0_BASE,
> > > +               .pfn            = __phys_to_pfn(TTC0_BASE),
> > >
> > > So it's also used as a physical address.  Yuck.
> >
> > I have been mapping everything flat (virt = phys) and I should have
been
> > clearer on that.
> >
> > It seems like there are two sets of #defines expected, virtual and
> > physical, even if they are the same.
> 
> Yes, it quickly gets messy otherwise. Normally, you only need to
specify
> very few physical addresses, e.g. the start of each register window.
> When you have separate defines for your virtual bases, you can also
> make them type safe right away, like:
> 
> #define PERIPH_BASE_PHYS 0xf800000
> #define PERIPH_BASE     IOMEM(PERIPH_BASE_PHYS)
> 
> #define TCC0_BASE 	(PERIPH_BASE + 0xA0000)
> #define TCC1_BASE	(PERIPH_BASE + 0xB0000)
> 
> This way, you don't need to convert the types in driver code.
> 

Thanks for clarification Arnd.  Appreciate the help.

-- John

> 	Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
