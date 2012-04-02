From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 07:31:14 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <alpine.LFD.2.02.1204012111260.24151@xanadu.home>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <CAKON4OyW2t+5GNRSEFOVjsGM8OifH7iqYNoO+BEOiGsdWq56sg@mail.gmail.com>
 <alpine.LFD.2.02.1204012111260.24151@xanadu.home>
Message-ID: <201204020731.14506.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Nicolas Pitre wrote:
> >  0xf1300000-0xf1a00000 is the virtual address.  0x13000000-0x21000000
> > is the physical address.  That's a span of 224MB.  How do the page
> > table entries work on ARM? I thought we only got 1MB per entry.  So I
> > need seven entries to span the range with the individual maps. I'd
> > need 224 entries to cover the entire region. Or can we make make the
> > page table entries any size we want?
> 
> You can't.  Arnd probably didn't notice that the physical range is not 
> contiguous.  What you have is pretty optimal.

Right, I didn't realize they were laid out like this in the physical space.

	Arnd
