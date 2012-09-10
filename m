From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 10 Sep 2012 07:53:39 +0200
Subject: [PATCH v3 02/31] arm64: Kernel booting and initialisation
In-Reply-To: <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-3-git-send-email-catalin.marinas@arm.com>
 <20120909172046.GB31430@game.jcrosoft.org>
 <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
Message-ID: <20120910055339.GC31430@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:29 Sun 09 Sep     , Nicolas Pitre wrote:
> On Sun, 9 Sep 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 17:26 Fri 07 Sep     , Catalin Marinas wrote:
> > > +4. Call the kernel image
> > > +------------------------
> > > +
> > > +Requirement: MANDATORY
> > > +
> > > +The decompressed kernel image contains a 32-byte header as follows:
> > > +
> > > +  u32 magic	= 0x14000008;	/* branch to stext, little-endian */
> > > +  u32 res0	= 0;		/* reserved */
> > > +  u64 text_offset;		/* Image load offset */
> > > +  u64 res1	= 0;		/* reserved */
> > > +  u64 res2	= 0;		/* reserved */
> > we need to have a magic to known it's a arm64 kernel
> 
> You have it: it's 0x14000008 at the beginning.
fragile
> 
> > > +
> > > +The image must be placed at the specified offset (currently 0x80000)
> > > +from the start of the system RAM and called there. The start of the
> > > +system RAM must be aligned to 2MB.
> > can we drop this
> 
> Drop what?
> And why?
This contrain the must be loadable at any address

Best Regards,
J.
