From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 15:42:31 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B1911B4.7080907@denx.de>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
Message-ID: <20091204154231.GB20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 02:42:12PM +0100, Heiko Schocher wrote:
> Hello Russell King,
> 
> Russell King - ARM Linux wrote:
> > On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
> >> [4] Log from Demoprogramm, not working
> > 
> > I think this is messed up - this is not from your first script but your
> > second script which starts four independent read processes.
> > 
> > I determined this because:
> > (1) the read thread addresses are mostly the same
> > (2) there are four "Read form in_msg" strings, which you only print
> > once at the start of the program.
> 
> Ups, sorry for the confusion, here 2 logs with the right values:

I don't remember whether 2.6.28 has highmem.  Can you check whether you're
using highmem please?
