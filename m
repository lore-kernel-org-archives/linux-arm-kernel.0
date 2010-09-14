From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Sep 2010 13:32:47 -0400 (EDT)
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <4C8E7EFF.7020004@endruntechnologies.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<20100913100111.GA30787@n2100.arm.linux.org.uk>
	<4C8E7EFF.7020004@endruntechnologies.com>
Message-ID: <alpine.LFD.2.00.1009141330230.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Sep 2010, Bruce M. Penrod wrote:

> 
> 
> Russell King - ARM Linux wrote:
> > On Mon, Sep 13, 2010 at 12:40:56AM -0700, Bruce M. Penrod wrote:
> > > This seems like a pretty straightforward question, but extensive web
> > > searching hasn't shown a really clear, up-to-date answer.  The most
> > > recent info is circa 2004 and states that 4MB is the largest  uncompressed
> > > ARM kernel that may be loaded.  Not being an ARM assembly  guru (head.S
> > > baffles me), I'd like to know if that is still true in  2010, and if it
> > > is, why?
> > 
> > It is no longer true; the only limit now is the size of contiguous RAM
> > to fit the kernel image into.
> > 
> 
> Interesting.  I finally was able to get an uncompressed kernel a little below
> 4MB, and now it boots.  I'm working with 2.6.35rc6 on an OpenRD Ultimate
> (Marvell Kirkwood) with Slackware, doing native compiles.  I'm wondering if
> there could be any problem with U-Boot for larger kernels than 4MB, but it
> doesn't complain and says that it is copying the image.  The symptom I had
> with a much larger kernel (~15MB) is a total hang, not even "Uncompressing
> linux".
> 
> I'll add some innocuous stuff back in until I get above 4MB again and see if
> it breaks again.

When it breaks, do you still see the "Uncompressing Linux... done, 
booting the kernel." message?


Nicolas
